class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :last]
  before_action :set_posts, only: [:index, :show, :last]

  def index
    @page = (params[:page] || 1).to_i
    @posts = @posts.paginate(page: @page, per_page: 10).order(created_at: :desc)
    if params[:tag]
      @posts = @posts.tagged_with([params[:tag]], any: true)
    end
    respond_to do |format|
      format.html
      format.json
      format.rss { render :layout => false }
    end
  end

  # TODO: clear pdfs
  def show
    @post = @posts.find_by(id: params[:id])
    render file: "#{Rails.root}/public/404.html" , status: 404  if @post.nil?
    respond_to do |format|
      format.html
      format.json
      format.md { render plain: "<!-- Title: " + @post.title + " -->\n\n" + @post.description }
      format.tex { render plain: @post.pandoc!(:tex) }
      format.pdf { send_data @post.pandoc!(:pdf), filename: "#{@post.id}-#{@post.title.tr(' ', '-')}.pdf", disposition: "inline" }
    end
  end

  def last
    if @posts.count.zero?
      redirect_to home_path, alert: "No readable post"
    else
      redirect_to read_path(@posts.order(created_at: :asc).last)
    end
  end

  def update
    @post = Post.find params[:id]
    if @post.update(post_params)
      render :show, status: :ok, location: read_path(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def create
    Post.create(title: "new", state: "draft")
    redirect_to :back
  end

  def destroy
    if Post.find(params[:id]).destroy
      redirect_to home_path
    else
      redirect_to read_path(@post)
    end
  end

  def publish
    Post.find(params[:id]).update_attributes(state: "published")
    redirect_to home_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :state, :tag_list)
  end

  def set_posts
    @posts = user_signed_in? ? Post.all : Post.published
  end
end

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :last]
  before_action :set_posts, only: [:index, :show, :last]

  api :GET, "/read(.:format)", "List the last article (by creation date)"
  param :page, :number, required: false
  param :format, %w(html json rss), required: false
  formats %w(html json rss)
  def index
    @page = (params[:page] || 1).to_i
    if params[:tag]
      @posts = @posts.tagged_with([params[:tag]], any: true)
    end
    @posts_count = @posts.size
    @posts = @posts.paginate(page: @page, per_page: 10).order(created_at: :desc)
    # @posts_count_current = @posts.size # TODO
    respond_to do |format|
      format.html
      format.json
      format.rss { render :layout => false }
    end
  end

  api :GET, "/read/:id(.:format)", "Get an existing article"
  param :id, :number, required: true
  param :format, %w(html json md tex bib pdf), required: false
  formats %w(html json md(markdown) tex(latex) bib(bibtex) pdf)
  def show
    @post = @posts.find_by(id: params[:id])
    render file: "#{Rails.root}/public/404.html" , status: 404  if @post.nil?
    respond_to do |format|
      format.html { render layout: false if request.xhr? }
      format.json
      format.md
      format.tex
      format.bib
      format.pdf { send_data @post.pandoc!(:pdf), filename: "#{@post.id}-#{@post.title.tr(' ', '-')}.pdf", disposition: "inline" }
    end
  end

  api :GET, "/last", "Get the last article"
  description "Note: This entry point does not keep the format"
  def last
    if @posts.count.zero?
      redirect_to home_path, alert: "No readable post"
    else
      redirect_to read_path(@posts.order(created_at: :asc).last)
    end
  end

  def update
    @post = Post.find params[:id]
    @post.short! if params[:short] == "true" # only "true" ? "1" ?
    if @post.update(post_params)
      if request.xhr?
        render :show, layout: false
      else
        render :show, status: :ok, location: read_path(@post)
      end
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

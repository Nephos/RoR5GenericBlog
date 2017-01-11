class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :last]

  def index
    if user_signed_in?
      @posts = Post.all.paginate(page: params[:page]).order(created_at: :desc)
    else
      @posts = Post.published.paginate(page: params[:page]).order(created_at: :desc)
    end
  end

  def show
    @post = Post.published.find_by(id: params[:id])
    render file: "#{Rails.root}/public/404.html" , status: 404  if @post.nil?
  end

  def last
    if Post.count.zero?
      redirect_to root_path
    else
      redirect_to read_path(Post.last)
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

  private
  def post_params
    params.require(:post).permit(:title, :description, :state)
  end
end

class HomeController < ApplicationController
  def index
    @posts = Post.published.paginate(page: params[:page]).order(:created_at)
  end

  def show
    @post = Post.published.find_by(id: params[:id])
    render file: "#{Rails.root}/public/404.html" , status: 404  if @post.nil?
  end

  def update
    @post = Post.find params[:id]
    if @post.update(post_params)
      render :show, status: :ok, location: read_url(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :state)
  end
end

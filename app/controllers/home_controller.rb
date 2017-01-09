class HomeController < ApplicationController
  def index
    @posts = Post.published.paginate(page: params[:page]).order(:created_at)
  end

  def show
    @post = Post.published.find_by(id: params[:id])
    render file: "#{Rails.root}/public/404.html" , status: 404  if @post.nil?
    # render 404 if @post.nil?
    # redirect_to :root, alert: "Post not found" if @post.nil?
  end
end

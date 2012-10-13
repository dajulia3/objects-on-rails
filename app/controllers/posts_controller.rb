class PostsController < ApplicationController
  def create
    @post = @blog.new_post(params[:post])
    @post.publish
    redirect_to root_path, notice: "Post added!"
  end

  def new
    @post = @blog.new_post
  end
end

class PostsController < ApplicationController
  def create
    @post = @blog.new_post(params[:post])
    if @post.publish
      redirect_to root_path, notice: "Post added!"
    else
      flash.now[:warning] = "Error, post could not be saved.<br/> -Title cannot be blank.".html_safe
      render "new"
    end
  end

  def new
    @post = @blog.new_post
  end
end

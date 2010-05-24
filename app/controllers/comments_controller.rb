class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(params[:comment])

    respond_with(@post) do |format|
      format.html { redirect_to @post }
      format.js   {render :layout => false}
    end
  end

end


class PostsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!, :except => [ :index, :show ]
  before_filter :get_post, :only => [ :edit, :update, :delete, :destroy ]

  def index
    @posts = Post.all
    respond_with @posts
  end

  def show
    @post = Post.find(params[:id])
    respond_with @post
  rescue
    redirect_to(posts_path, :notice => '*Post not found!')
  end

  def new
    @post = Post.new
  end

  def edit
    #@post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to(@post, :notice => 'Post was successfully created.')
    else
      render "new"
    end
  end

  def update
    #@post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.')
    else
      render "edit"
    end
  end

  def delete
    #@post = Post.find( params[:id] )
  end

  def destroy
    #@post = Post.find(params[:id])
    redirect_to(@post) and return if params[:cancel]

    @post.destroy
    redirect_to posts_path, :notice => "#{@post.title} was deleted"
  end

  protected

  def get_post
    @post = Post.by_user(current_user).find(params[:id])
  rescue
    redirect_to(posts_path, :notice => '**Post not found!')
  end
end


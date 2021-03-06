class PostsController < ApplicationController

  def index
    # ########## my original refactor - works same ###################################
    # if !params[:author].blank?
    #   @posts = Post.by_author(params[:author])
    # elsif !params[:date].blank?
    #   @posts = Post.by_date(params[:date])
    # else
    #   @posts = Post.all
    # end

    # ########## school refactor ###################################
    if !params[:author].blank?
      @posts = Post.by_author(params[:author])
    elsif !params[:date].blank?
      if params[:date] == "Today"
        @posts = Post.from_today
      else
        @posts = Post.old_news
      end      
    else
      @posts = Post.all
    end

    @authors = Author.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end

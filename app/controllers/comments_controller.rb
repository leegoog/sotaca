class CommentsController < ApplicationController
    before_filter :authenticate_user!
  
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create!(params[:comment])  
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to comment_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    set = @comment.article_set.id
    @comment.destroy
    flash[:notice] = "comment deleted."
    redirect_to article_set_path(set)
  end
end

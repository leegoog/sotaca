class ArticleSetLikesController < ApplicationController
  def create
    @article_set_like = ArticleSetLike.new(params[:article_set_like])
    if @article_set_like.save
      flash[:notice] = "You like this Set! Thank you."
      redirect_to article_sets_path
    else
      render :action => 'new'
    end
  end

  def destroy
    @article_set_like = ArticleSetLike.find(params[:id])
    @article_set_like.destroy
    flash[:notice] = "Set unliked."
    redirect_to root_url
  end
end

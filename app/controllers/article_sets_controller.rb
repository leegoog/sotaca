class ArticleSetsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @article_sets = ArticleSet.order('created_at desc').page(params[:page]).per( params[:per_page] ? params[:per_page] : 5)
  end

  def show
    @article_set = ArticleSet.find(params[:id])
    @comments = @article_set.comments.order("created_at desc")
  end

  def new
    @article_set = ArticleSet.new
    @article_set_id = ArticleSet.count+1
    @products = Product.all
  end

  def create
    @article_set = ArticleSet.new(params[:article_set])
    if @article_set.save
      flash[:notice] = "Successfully created article set."
      redirect_to @article_set
    else
      render :action => 'new'
    end
  end

  def edit
   @article_set = ArticleSet.find(params[:id])
   @products = Product.all
   # TODO: until editing is posible, redirect
   flash[:notice] = "A Set can not be edited once it was published."
   redirect_to @article_set
  end

  def update
    @article_set = ArticleSet.find(params[:id])
    if @article_set.update_attributes(params[:article_set])
      flash[:notice] = "Successfully updated article set."
      redirect_to article_set_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @article_set = ArticleSet.find(params[:id])
    @article_set.destroy
    flash[:notice] = "Successfully destroyed article set."
    redirect_to article_sets_url
  end
end

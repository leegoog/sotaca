class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    @user = User.find(params[:id]) || current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile has been updated."
      redirect_to "/"
    else
      render :action => 'edit'
    end
  end 
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User deleted."
    redirect_to users_url
  end

end

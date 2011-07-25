module SessionsHelper

  # use this helper method to restrict access and force the user to login
  def deny_access
    store_location
    flash[:error] = t "needs_login"
    redirect_to new_user_session_path
  end

  # check if user is signed in
  def anyone_signed_in?
    !current_user.nil?
  end

  private
    
    # store location to return to
    def store_location
      session[:return_to] = request.fullpath
    end
    # clear location to return to
    def clear_stored_location
      session[:return_to] = nil
    end

end

class AdminController < ApplicationController
  
  before_filter :authenticate_superuser!
  
  def index
  end

end

class StartImage < ActiveRecord::Base
  
  attr_accessible :link, :image
  
  mount_uploader :image, StartImageUploader
  
end

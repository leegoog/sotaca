class StartImage < ActiveRecord::Base
  
  attr_accessible :link, :image
  
  validates_presence_of :image, :on => :create, :message => "can't be blank"
  
  mount_uploader :image, StartImageUploader
  
end

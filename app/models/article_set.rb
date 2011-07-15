require 'RMagick'

class ArticleSet < ActiveRecord::Base
  
    mount_uploader :blog_image, BlogImageUploader
    
    validates_presence_of :name
    validates_length_of :name, :minimum => 3

    # creator
    belongs_to :user
    
    # products m:n
    has_many :products, :through => :set_items
    has_many :set_items, :dependent => :destroy
    
    # users m:n (people liking this set)
    has_many :users, :through => :likes
    has_many :likes, :class_name => 'ArticleSetLike', :dependent => :destroy
    
    # comments
    has_many :comments, :dependent => :destroy 
    
    accepts_nested_attributes_for :set_items, :allow_destroy => true  
    
    after_create :create_collage
    
    
    def create_collage
      # load the template
      
      #template 
      # template = Magick::Image.read("#{RAILS_ROOT}/public/images/set_template.png").first
      # or blank white image
      template = Magick::Image.new(600, 480){
        self.background_color = 'white'
       }
      
      
      # go through all set items by z_index and add lay it over the template
      for item in self.set_items
        photo = Magick::Image.read(item.product.assets.first.image.url(:thumb).to_s).first
        photo = photo.scale(item.width, item.height)
        photo = photo.rotate(item.rotation)
        # composite item over template offsetting pos_x and pos_y for the template border
        template.composite!(photo, item.pos_x, item.pos_y, Magick::OverCompositeOp)
      end
      
      img_path = "#{RAILS_ROOT}/tmp/sets/"
      img_name = "set_#{self.id}_#{Time.now.to_i}.png"
      
      # save composite image to PNG
      template.write(img_path + img_name)  # this works, it generates the desired PNG
      #save and upload to s3
      
      tmp_image = File.open(img_path + img_name)
      
      self.blog_image = tmp_image
        
      self.write_blog_image_identifier
      
      self.save!
      
      File.delete(img_path + img_name)
      
    end
    
end

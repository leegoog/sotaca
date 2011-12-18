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
    has_many :comments, :dependent => :destroy, :order => "created_at DESC"  
    
    accepts_nested_attributes_for :set_items, :allow_destroy => true  
    
    #after_create :create_collage

    scope :by_user, lambda {|user_id| 
      where(:user_id => user_id)
    }
    
    
    # creates an png image collage from all the associated set items of this article set
    def create_collage
      # load the template
      
      
      img_path = "#{::Rails.root.to_s}/tmp/sets/"
      img_name = "set_#{self.id}_#{Time.now.to_i}"
      
      #template 
      # template = Magick::Image.read("#{RAILS_ROOT}/public/images/set_template.png").first
      # or blank white image
      template = Magick::Image.new(600, 480){
        self.background_color = '#ffffff'
       }
      
      template.format = 'png'
      # template.filename = img_name
      
      # go through all set items by z_index and add lay it over the template
      for item in self.set_items.order("z_index asc")
        photo = Magick::Image.read(item.product.assets.first.image.url(:thumb).to_s).first
        photo = photo.scale(item.width, item.height)
        photo = photo.rotate(item.rotation)
        # composite item over template offsetting pos_x and pos_y for the template border
        template.composite!(photo, item.pos_x, item.pos_y, Magick::OverCompositeOp)
      end

      # create temp file 
      
      tmp_image = Tempfile.new([img_name, '.png'])
      
      # write rmagick image in tempfile
      
      template.write(tmp_image.path)
      
      # save & upload with carrierwave
  
      self.blog_image = tmp_image
      
      # self.blog_image.store!(template)
        
      self.write_blog_image_identifier
      
      self.save!
      
      #File.delete(img_path + img_name)
      
      tmp_image.delete
      
    end
    
end

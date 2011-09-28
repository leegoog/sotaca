class CollageCreator  
  @queue = :collage_queue  
  def self.perform(article_set_id)  
    set = ArticleSet.find(article_set_id)  
    #set.create_collage
    
     # load the template
      
      
      img_path = "#{::Rails.root.to_s}/tmp/sets/"
      img_name = "set_#{set.id}_#{Time.now.to_i}"
      
      #template 
      # template = Magick::Image.read("#{RAILS_ROOT}/public/images/set_template.png").first
      # or blank white image
      template = Magick::Image.new(600, 480)
      
      template.format = 'png'
      # template.filename = img_name
      
      # go through all set items by z_index and add lay it over the template
      for item in set.set_items.order("z_index asc")
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
  
      set.blog_image = tmp_image
      
      # self.blog_image.store!(template)
        
      set.write_blog_image_identifier
      
      set.save!
      
      #File.delete(img_path + img_name)
      
      tmp_image.delete
    
    
  end  
end
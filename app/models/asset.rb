class Asset < ActiveRecord::Base
    
    belongs_to :product
    mount_uploader :image, ImageUploader
    
    # validates_presence_of :product_id
    # validates_numericality_of :product_id

    def image=(val)
      if !val.is_a?(String) && valid?
        image_will_change!
        super
      end
    end
    
end

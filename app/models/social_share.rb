class SocialShare < ActiveRecord::Base
  include ActiveModel::Validations

    validates_presence_of :email, :sender_name, :sender_mail, :name
    
    validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
    validates_format_of :sender_mail, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
    
    attr_accessor :message
    
    
    belongs_to :product

    def initialize(attributes = {})
      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
      @attributes = attributes
    end

    def read_attribute_for_validation(key)
      @attributes[key]
    end

    def to_key
    end

    def save
      if self.valid?
        SocialMailer.social_share(self).deliver!
        return true
      end
      return false
    end
end

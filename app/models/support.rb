# dummy class for all kinds of messaging from Customer to Shop-Owner, e.g. Feedback, Contact Form, etc.
# no database table

class Support
  include ActiveModel::Validations

    validates_presence_of :email, :sender_name, :support_type, :content
    
    validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
    
    # to deal with form, you must have an id attribute
    attr_accessor :id, :email, :sender_name, :support_type, :content, :order_nr, :item_id

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
        Notifier.contact_notification(self).deliver!
        return true
      end
      return false
    end
end

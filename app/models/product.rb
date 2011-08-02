class Product < ActiveRecord::Base
   translates :title, :subtitle, :description, :fallbacks_for_empty_translations => true
   
   accepts_nested_attributes_for :translations # allows multiple translations in the same request
   
   # validations
    validates_presence_of :title, :price
    validates :price, :numericality => { :greater_than => 0 }
  
   # associations  
    has_many :categorizations, :dependent => :destroy
    has_many :categories, :through => :categorizations
 
    has_many :users, :through => :likes
    has_many :likes, :class_name => 'ProductLike', :dependent => :destroy
    
    has_many :assets, :dependent => :destroy
    
  # for article sets
    has_many :article_sets, :through => :set_items
    has_many :set_items, :dependent => :destroy
    
   # for cart
    has_many :line_items, :dependent => :destroy
    
   # virtual attributes
    attr_writer :category_names
    
   # callback for create categories through product
    after_save :assign_categories
    
   # allow creation & deletion of assets through product
    accepts_nested_attributes_for :assets, :allow_destroy => true
    
   # scopes
    scope :by_category, lambda{|cat| where(:category => cat) } 
    
    composed_of :price,
                  :class_name => 'Money',
                  :mapping => %w(price cents),
                  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
    
    # getter method for category_names, used to prepopulate the text_field in the view
    def category_names
      @category_names || categories.map(&:name).join(' ')
    end
    
    def to_param
      "#{id}-#{title.parameterize}"
    end
    
    private
    
    # assigns categories to the product, if the entered category doesn't exist, this method will create that record "on the fly"
    def assign_categories 
      if @category_names 
        self.categories = @category_names.split(/\s+/).map do |name|
          Category.find_or_create_by_name(name)
        end
      end
    end
    
end

class Product < ActiveRecord::Base
   translates :title, :subtitle, :description, :fallbacks_for_empty_translations => true
   
   accepts_nested_attributes_for :translations # allows multiple translations in the same request
   
    # validations
    validates_presence_of :title, :price
    validates :price, :numericality => { :greater_than => 0 }
  
    # associations  
    # has_many :categorizations, :dependent => :destroy
    # has_many :categories, :through => :categorizations
  
    belongs_to :category
 
    has_many :users, :through => :likes
    has_many :likes, :class_name => 'ProductLike', :dependent => :destroy
    
    has_many :assets, :dependent => :destroy
    
  # for article sets
    has_many :article_sets, :through => :set_items
    has_many :set_items, :dependent => :destroy
    
   # for cart
    has_many :line_items, :dependent => :destroy
    
  # for stock management
    has_many :stock_items
    
   # virtual attributes
    attr_writer :category_names
    
    attr_accessor :title_code
    
   # callback for create categories through product
    after_save :assign_categories
    
   # allow creation & deletion of assets through product
    accepts_nested_attributes_for :assets, :allow_destroy => true
    
   # scopes
    scope :by_category, lambda{|cat| where(:category => cat) } 
    scope :active, where(:legacy => false)
    scope :legacy, where(:legacy => true)
    
    composed_of :price,
                  :class_name => 'Money',
                  :mapping => %w(price cents),
                  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
    
    # getter method for category_names, used to prepopulate the text_field in the view
    def category_names
      @category_names || categories.map(&:name).join(' ')
    end
    
    # overriding rails' to_param method to get a speaking, seo friendlier URI
    def to_param
      "#{id}-#{title.parameterize}"
    end
    
    def full_name
        [product_code, title, id].reject(&:blank?).join(' ')
    end
    
    def self.tree(category=nil) 
      return scoped unless category
      scoped.select("distinct(products.id), products.*").joins(:category).where(["categories.lft BETWEEN ? AND ?", category.lft, category.rgt])
    end
    
    def title_code
      "#{self.product_code} - #{self.title}"
    end
    
    def total_stock
      self.stock_items.to_a.sum(&:amount)
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

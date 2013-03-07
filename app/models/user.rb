class User < ActiveRecord::Base
  
  # Setup accessible (or protected) attributes for your model
   attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :login, :wishlist_attributes 

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  
  after_create :create_wishlist

  
  has_many :carts
  
  has_many :article_sets
  
  # can like products
  has_many :products, :through => :product_likes
  has_many :product_likes, :dependent => :destroy
  
  # can like sets
  has_many :article_sets, :through => :likes
  has_many :likes, :class_name => 'ArticleSetLike', :dependent => :destroy
  
  # can comment
  has_many :comments, :dependent => :destroy 
  
  # can order
  has_many :orders
  
  # wishlist
  has_one :wishlist
  
  # order / shipping adresses, avoid re-typing
  has_many :adresses
  
  has_and_belongs_to_many :roles

  validates_presence_of :username
  validates_uniqueness_of :username, :allow_blank => false
  
  validates_length_of :username, :minimum => 3, :maximum => 16, :allow_blank => true
  
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)

    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  # check if the saved hash equals the newly encrypted (password matches)
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  # creates the users wishlist after registration 
  def create_wishlist
    self.build_wishlist(:user_id => self.id)
  end
  
  # adds an item to the user's wishlist (takes product ID)
  def add_to_wishlist(product)
    wishlist.products << product unless wishlist.products.include?(product)
    wishlist.save
  end
  
  def remove_from_wishlist(product)
    if wishlist.products.include?(product)
      wishlist.products.delete(product)
      wishlist.save
    end
  end
  
  
  protected

 
 # looks for either username or email to authenticate
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

   # Attempt to find a user by it's email. If a record is found, send new
   # password instructions to it. If not user is found, returns a new user
   # with an email not found error.
   def self.send_reset_password_instructions(attributes={})
     recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
     recoverable.send_reset_password_instructions 
     recoverable
   end 

   def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
     (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

     attributes = attributes.slice(*required_attributes)
     attributes.delete_if { |key, value| value.blank? }

     if attributes.size == required_attributes.size
       if attributes.has_key?(:login)
          login = attributes.delete(:login)
          record = find_record(login)
       else  
         record = where(attributes).first
       end  
     end  

     unless record
       record = new

       required_attributes.each do |key|
         value = attributes[key]
         record.send("#{key}=", value)
         record.errors.add(key, value.present? ? error : :blank)
       end  
     end  
     record
   end
   # needed for devise
   def self.find_record(login)
     where(["username = :value OR email = :value", { :value => login }]).first
   end

   # needed for devise
   def role?(role)
       return !!self.roles.find_by_name(role.to_s.camelize)
   end

  private

  # prepares the password for database storage (dont ever save plain text passwords)
  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
 # encrypts the password again each time the users logs in to compare with value from database
  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
end

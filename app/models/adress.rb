class Adress < ActiveRecord::Base
  
  attr_accessible :user_id, :title, :first_name, :last_name, :adress1, :adress2, :zip, :city, :county, :country, :phone1, :phone2, :adress_type, :active
  
  validates_presence_of :first_name, :last_name, :adress1, :city, :country, :zip, :adress_type
  
  belongs_to :user
  
  scope :active, where(:active => true)
  scope :shipping, where(:adress_type => "Shipping")
  scope :billing, where(:adress_type => "Billing")
  
end

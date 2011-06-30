class OrderTransaction < ActiveRecord::Base
  
  belongs_to :order 
  
  # params is a hash object that needs to be serialized before storing it to the db
  serialize :params
  
  # response setter
  def response=(response)
    self.success       = response.success?
    self.authorization = response.authorization
    self.message       = response.message
    self.params        = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success       = false
    self.authorization = nil
    self.message       = e.message
    self.params        = {}
  end
  
end

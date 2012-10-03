#CarrierWave.configure do |config|
#  config.root = Rails.root.join('tmp')
#  config.cache_dir = 'carrierwave'
#  config.s3_access_key_id = 'AKIAIDT3PICOOCOD4U3A'
#  config.s3_secret_access_key = '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'
#  config.s3_bucket = 'sotaca'
#  config.s3_region = 'eu-west-1'
#end
#

CarrierWave.configure do |config|
  
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'
  
  ### THOMAS ###
  #config.fog_credentials = {
  #  :provider               => 'AWS',                                            # required
  #  :aws_access_key_id      => 'AKIAIDT3PICOOCOD4U3A',                           # required
  #  :aws_secret_access_key  => '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',       # required
  #  :region                 => 'eu-west-1'                                       # optional, defaults to 'us-east-1'
  #}
  #config.fog_directory  = 'sotaca'                                 # required
  #config.fog_host       = 'http://sotaca.s3.amazonaws.com'         # optional, defaults to nil
  
  
  ### LEEGOO ###
  
  config.fog_credentials = {
    :provider               => 'AWS',                                            # required
    :aws_access_key_id      => 'AKIAJQNB77WSRJN64BIA',                           # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'eu-west-1'                                       # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'sotacauk'                                 # required
  config.fog_host       = 'http://sotacauk.s3.amazonaws.com'         # optional, defaults to nil 
  
  #config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}   # optional, defaults to {}
end
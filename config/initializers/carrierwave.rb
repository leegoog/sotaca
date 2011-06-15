CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'

  config.s3_access_key_id = 'AKIAIDT3PICOOCOD4U3A'
  config.s3_secret_access_key = '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'
  config.s3_bucket = 'sotaca'
end
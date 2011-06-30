require "i18n/backend/fallbacks" 

# use redis translation store, more info on redis.io
TRANSLATION_STORE = Redis.new  
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)

# fallback to english if chínese translation is missing
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.fallbacks.map('cn' => 'en')


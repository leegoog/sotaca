require "i18n/backend/fallbacks" 

module I18n
  module Backend
    class Chain
      module Implementation
        def store_translations(locale, data, options = {})
          backends.first.store_translations(locale, data, {:escape => false})
        end
      end
    end
  end
end

# use redis translation store, more info on redis.io
uri = URI.parse(ENV["REDISTOGO_URL"])
TRANSLATION_STORE = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)  
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(TRANSLATION_STORE), I18n.backend)

# fallback to english if chínese translation is missing
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.fallbacks.map('cn' => 'en')


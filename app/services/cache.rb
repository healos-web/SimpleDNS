class Cache
  @redis = Redis.new

  class << self
    attr_reader :redis

    def fetch(key, expires_in = 30, &block)
      cached = redis.get(key)
      cached = JSON.parse(cached) if cached

      if cached && (cached['expiration_time'] > Time.now.to_i)
        # fetch and return result
        puts "fetch from cache and will expire in #{cached['expiration_time'] - Time.now.to_i}"
        cached['value']
      else
        if block_given?
          # execute block and create a new entry for the request result
          puts "did not find key in cache, executing block ..."
          value =  yield(block)
          redis.set(key, {value: value, expiration_time: Time.now.to_i + expires_in}.to_json)
          value
        else
          # no block given, do nothing
          nil
        end
      end
    end
  end
end
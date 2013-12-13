module UserSettings
  class Key
    class << self
      def create_or_update(user_id, key, value = nil)
        UserSettings.redis.setex redisable_key(user_id, key), UserSettings.expiration_time, value
      end

      def create(user_id, key, value)
        if find(user_id, key)
          false
        else
          create_or_update(user_id, key, value)
        end
      end

      def find(user_id, key)
        UserSettings.redis.get redisable_key(user_id, key)
      end

      def remove(user_id, key)
        UserSettings.redis.del redisable_key(user_id, key)
      end

      private
      def redisable_key(user_id, key)
        "usersetting:#{user_id}:#{key}"
      end
    end
  end
end

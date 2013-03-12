class Post < ActiveRecord::Base
  attr_accessor :username, :time_left, :city_and_state 
  
  class << self
    alias_method :old_find, :find

    def find(post_id)
      Rails.cache.fetch "post#{post_id}" do
        results = old_find(post_id)
      end
    end
  end
end

class City < ActiveRecord::Base
  def self.find_in_cache(city_id)
    Rails.cache.fetch "city:#{city_id}" do
      results = find(city_id)
    end
  end

  def self.get_all_cities_in_cache(state_id)
    Rails.cache.fetch "cities:#{state_id}" do
      results = where("state_id = #{state_id}")
    end
  end
end

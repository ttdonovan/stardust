class State < ActiveRecord::Base
  def self.find_in_cache(state_id)
    Rails.cache.fetch "state#{state_id}" do
      results = find(state_id)
    end
  end
  
  def self.all_in_cache
    Rails.cache.fetch 'states' do
      results = all
    end
  end
end

class City < ActiveRecord::Base
  class << self
    alias_method :old_all, :all

    def all
      Rails.cache.fetch 'cities' do
        results = old_all
      end
    end
    
    def get_all_by_state(state_id)
      key = "state#{state_id}"
      
      Rails.cache.fetch key do
        results = find(:all, :conditions => {:state_id => state_id})
      end
    end
  end
end
class State < ActiveRecord::Base
  class << self
    alias_method :old_all, :all

    def all
      Rails.cache.fetch 'states' do
        results = old_all
      end
    end
  end
end

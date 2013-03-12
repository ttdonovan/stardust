class User < ActiveRecord::Base  
  before_save :encrypt_password

  attr_accessor :password, :password_confirmation

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  class << self
    alias_method :old_find, :find

    def find(user_id)
      Rails.cache.fetch "user#{user_id}" do
        results = old_find(user_id)
      end
    end
  end
end
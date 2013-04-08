# == Schema Information
#
# Table name: credentials
#
#  id         :integer          not null, primary key
#  provider   :string(255)      not null
#  user_id    :integer          not null
#  uid        :string(255)      not null
#  name       :string(255)      default("")
#  email      :string(255)      default("")
#  info       :text             default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_credentials_on_email             (email)
#  index_credentials_on_provider_and_uid  (provider,uid)
#  index_credentials_on_user_id           (user_id)
#

class Credential < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    # TODO: need to cleanup User model after full transition to Omniauth
    user = User.create do |u|
      u.username = auth['info']['email']
      u.password = BCrypt::Engine.generate_salt
    end
    create! do |cred|
      cred.user       = user
      cred.provider   = auth['provider']
      cred.uid        = auth['uid']
      cred.name       = auth['info']['name']
      cred.email      = auth['info']['email']
      cred.info       = '' # TODO: should we capture all the available information from omniauth?
    end
  end
end

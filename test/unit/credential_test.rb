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

require 'test_helper'

class CredentialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

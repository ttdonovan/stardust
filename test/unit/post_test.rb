# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  title          :string(255)
#  location       :string(255)
#  identification :string(255)
#  activity       :string(255)
#  state_id       :integer
#  city_id        :integer
#  duration       :integer
#  delay          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

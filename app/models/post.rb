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

class Post < ActiveRecord::Base
  belongs_to :user

  def get_city
    City.find_in_cache(city_id).name
  end

  def get_state
    State.find_in_cache(state_id).name
  end

  def time_left
    time_left = ""

    current_time = Time.parse(Time.now.strftime('%Y-%m-%d %H:%M:%S')).utc
    end_time = Time.parse( (created_at + duration.minutes).to_s )

    if (current_time > end_time)
      time_left = "This posting has ended."
    else
      time_hash = Time.diff(current_time, end_time)

      minutes = time_hash[:minute]
      hours = time_hash[:hour]

      time_left = "Less than a minute left" if (hours == 0 && minutes == 0)
      time_left = "#{minutes} minutes left" if (hours == 0 && minutes > 0)
      time_left = "#{hours} hours left" if (hours > 0 && minutes == 0)
      time_left = "#{hours} hours #{minutes} minutes left" if (hours > 0 && minutes > 0)
    end

    return time_left
  end
end

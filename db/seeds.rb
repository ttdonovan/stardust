# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# load cities and states
State.delete_all
City.delete_all

states = File.open("db/states/States.txt")
states.each do |state_name|
  state_name = state_name.delete("\r")
  state_name = state_name.delete("\n")
  state = State.create(:name => state_name)
  
  
  cities = File.open("db/states/#{state_name}.txt")
  cities.each do |city_name|
    city_name = city_name.delete("\r")
    city_name = city_name.delete("\n")
    City.create(:state_id => state.id, :name => city_name)
  end
end
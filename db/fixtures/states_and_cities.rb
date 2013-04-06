# load cities and states
State.delete_all
City.delete_all

File.open('db/fixtures/states/States.txt').each do |state_name|
  state_name = state_name.chomp

  State.seed do |s|
    s.name = state_name
  end

  File.open("db/fixtures/states/#{state_name}.txt").each do |city_name|
    state = State.find_by_name(state_name)
    city_name = city_name.chomp

    City.seed do |c|
      c.name      = city_name.titleize
      c.state_id  = state.id
    end
  end
end

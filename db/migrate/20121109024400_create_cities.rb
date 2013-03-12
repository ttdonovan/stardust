class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :id
      t.integer :state_id
      t.string :name
    end
    
    add_index(:cities, :state_id)
  end
end
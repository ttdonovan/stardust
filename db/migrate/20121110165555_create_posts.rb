class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :location
      t.string :identification
      t.string :activity
      t.integer :state_id
      t.integer :city_id
      t.integer :duration
      t.integer :delay

      t.timestamps
    end
  end
end

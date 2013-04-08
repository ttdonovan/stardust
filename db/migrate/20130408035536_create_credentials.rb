class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.references :user,   null: false
      t.string :provider,   null: false
      t.string :uid,        null: false
      t.string :name,       default: ''
      t.string :email,      default: ''
      t.text   :info,       default: ''
      t.timestamps
    end

    add_index :credentials, [:provider, :uid]
    add_index :credentials, :user_id
    add_index :credentials, :email
  end
end

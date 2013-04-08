class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name,             default: ''
      t.string :email,            null: false, unique: true
      t.string :password_digest,  null: false

      t.timestamps
    end

    add_index :identities, :email
  end
end

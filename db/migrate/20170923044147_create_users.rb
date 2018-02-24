class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :contact
      t.string :currently_reserved
      t.timestamps
      # t.string :provider, null: false
      # t.string :uid, null: false
      # add_index :users, :provider
      # add_index :users, :uid
      # add_index :users, [:provider, :uid], unique: true
    end
  end
end

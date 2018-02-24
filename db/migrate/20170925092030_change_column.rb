class ChangeColumn < ActiveRecord::Migration[5.1]
  def change
    add_column "reservations","user_id", :string
    add_column "reservations","car_id", :string
  end
end

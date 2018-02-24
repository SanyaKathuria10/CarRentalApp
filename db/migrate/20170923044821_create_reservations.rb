class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :rid
      t.datetime :checkout_time
      t.datetime :return_time
      t.string :location
      t.float :total_bill
      t.string :reservation_status
      t.timestamps
    end
  end
end

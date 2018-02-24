class RemoveLocationReservation < ActiveRecord::Migration[5.1]
  def change
    remove_column "reservations","location", :string
  end
end

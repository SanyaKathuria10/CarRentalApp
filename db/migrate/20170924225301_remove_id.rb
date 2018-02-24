class RemoveId < ActiveRecord::Migration[5.1]
  def change
    remove_column("users","uid")
    remove_column("cars","cid")
    remove_column("reservations","rid")
  end
end

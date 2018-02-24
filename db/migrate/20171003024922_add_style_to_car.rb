class AddStyleToCar < ActiveRecord::Migration[5.1]
    def change
      add_column "cars","style", :string
      remove_column "cars","status", :string
    end
end

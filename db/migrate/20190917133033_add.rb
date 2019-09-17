class Add < ActiveRecord::Migration[5.0]
  def change
    change_table :vehicles do |t|
      t.integer :driver_id
    end
  end
end

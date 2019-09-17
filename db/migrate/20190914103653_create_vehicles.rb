class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string   :name, limit: 255, null: false
      t.string   :code, limit: 20, null: false
      t.string   :vehicle_class, limit: 20
      t.string   :brand,  limit: 20
      t.string   :model, limit: 50
      t.integer  :model_year
      t.integer  :fuel_capacity
      t.string   :fuel_type, limit: 10
      t.string   :status, limit: 20, default: "active"
      t.date     :purchase_date

      t.timestamps
    end
  end
end

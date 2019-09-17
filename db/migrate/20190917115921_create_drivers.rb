class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string  :name, limit: 255, null: false
      t.string  :surname, limit: 255, null: false
      t.date    :birth_date
      t.numeric :tc_no, limit: 11
      t.numeric :phone, limit: 30
      t.string  :address, limit: 255

      t.timestamps
    end
  end
end

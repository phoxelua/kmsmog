class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.string :license_plate
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :customers, :users
    add_index :customers, [:user_id, :name]
  end
end

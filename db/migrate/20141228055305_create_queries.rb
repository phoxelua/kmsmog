class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :name
      t.string :phone
      t.string :license_plate

      t.timestamps null: false
    end
  end
end

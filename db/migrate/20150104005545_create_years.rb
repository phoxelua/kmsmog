class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.string :name
      t.references :model, index: true

      t.timestamps null: false
    end
    add_foreign_key :years, :models
  end
end

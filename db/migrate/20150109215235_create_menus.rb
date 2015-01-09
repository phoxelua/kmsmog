class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :service
      t.string :price
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :menus, :users
  end
end

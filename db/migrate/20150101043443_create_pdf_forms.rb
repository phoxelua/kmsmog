class CreatePdfForms < ActiveRecord::Migration
  def change
    create_table :pdf_forms do |t|
      t.text :content
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_index :pdf_forms, [:customer_id, :created_at]
    add_foreign_key :pdf_forms, :customers
  end
end

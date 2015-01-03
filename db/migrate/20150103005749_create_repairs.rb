class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.string :op
      t.text :instruction
      t.integer :svc
      t.references :pdf_form, index: true

      t.timestamps null: false
    end
    add_foreign_key :repairs, :pdf_forms
  end
end

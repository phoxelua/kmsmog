class AddFileToPdfForms < ActiveRecord::Migration
  def change
    add_column :pdf_forms, :file, :string
  end
end

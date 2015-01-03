class ChangeOpTypeInRepairs < ActiveRecord::Migration
  def change
  	change_column :repairs, :op, :integer
  end
end

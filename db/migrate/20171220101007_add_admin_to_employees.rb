class AddAdminToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :admin, :boolean
  end
end

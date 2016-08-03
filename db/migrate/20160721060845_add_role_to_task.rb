class AddRoleToTask < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :role, foreign_key: true
  end
end

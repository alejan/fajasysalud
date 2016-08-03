class CreateEmployee < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :last
      t.string :phone
      t.string :address
      t.string :email
    end
  end
end

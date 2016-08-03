class CreateCompany < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :nit
      t.string :website
      t.string :email
      t.string :phone
      t.string :address
    end
  end
end

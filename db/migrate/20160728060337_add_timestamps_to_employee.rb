class AddTimestampsToEmployee < ActiveRecord::Migration[5.0]
  def change
      add_column(:employees, :created_at, :datetime)
      add_column(:employees, :updated_at, :datetime)
  end
end

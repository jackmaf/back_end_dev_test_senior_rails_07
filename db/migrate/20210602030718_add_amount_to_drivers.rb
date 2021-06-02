class AddAmountToDrivers < ActiveRecord::Migration[6.1]
  def change
    add_column :drivers, :amount, :integer, default: 0
  end
end

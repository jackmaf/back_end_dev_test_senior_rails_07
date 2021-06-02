class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :id_wompi
      t.integer :amount
      t.string :status

      t.timestamps
    end
  end
end

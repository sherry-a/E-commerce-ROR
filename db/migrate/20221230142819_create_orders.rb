class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.string :total_products
      t.integer :total_price
      t.integer :status

      t.timestamps
    end
  end
end

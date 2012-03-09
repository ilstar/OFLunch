class CreateBalanceLogs < ActiveRecord::Migration
  def change
    create_table :balance_logs do |t|
      t.integer :balance_id
      t.float :amount
      t.integer :order_id
      t.string :operation

      t.timestamps
    end
  end
end

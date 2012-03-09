class ChangeFloatToDecimal < ActiveRecord::Migration
  def up
    change_column :balances, :amount, :decimal, :precision => 10, :scale => 2  
    change_column :balance_logs, :amount, :decimal, :precision => 10, :scale => 2  
  end

  def down
    change_column :balances, :amount, :float
    change_column :balance_logs, :amount, :float
  end
end

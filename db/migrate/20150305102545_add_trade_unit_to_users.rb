class AddTradeUnitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trade_unit, :float
  end
end

class ChangeTradeUnitinUsers < ActiveRecord::Migration
  def change
    change_column :users, :trade_unit, :integer
  end
end

class ChangeResultinTrades < ActiveRecord::Migration
  def change
    change_column :trades, :result, :float
  end
end

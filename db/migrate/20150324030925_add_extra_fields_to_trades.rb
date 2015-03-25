class AddExtraFieldsToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :entry, :float
    add_column :trades, :stoploss, :float
    add_column :trades, :targetone, :float
    add_column :trades, :targettwo, :float
    add_column :trades, :targetthree, :float
  end
end

class AddUserIdToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :user_id, :integer
    add_index :trades, :user_id
  end
end

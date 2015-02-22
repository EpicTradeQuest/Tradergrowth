class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :result
      t.text :description

      t.timestamps null: false
    end
  end
end

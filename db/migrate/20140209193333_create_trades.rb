class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.string :action
      t.string :status
      t.decimal :price
      t.integer :shares
      t.datetime :date_posted
      t.integer :stock_id

      t.timestamps
    end
  end
end

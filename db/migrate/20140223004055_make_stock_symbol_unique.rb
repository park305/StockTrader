class MakeStockSymbolUnique < ActiveRecord::Migration
  def change
  	add_index :stocks, :symbol, :unique => true
  end
end

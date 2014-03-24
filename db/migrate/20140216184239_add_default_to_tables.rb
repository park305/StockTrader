class AddDefaultToTables < ActiveRecord::Migration
  def change
    change_column :stocks, :cost, :decimal, default: 0
    change_column :stocks, :shares, :integer, default: 0  	
    change_column :trades, :status, :string, default: "Active"  	
    change_column :trades, :price, :decimal, default: 0  	
    change_column :trades, :shares, :integer, default: 0  	
  end
end


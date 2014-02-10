class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.decimal :cost
      t.integer :shares

      t.timestamps
    end
  end
end

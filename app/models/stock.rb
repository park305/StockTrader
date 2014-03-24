class Stock < ActiveRecord::Base
	has_many :trades
	validates_uniqueness_of :symbol
	accepts_nested_attributes_for :trades
end

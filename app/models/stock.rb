class Stock < ActiveRecord::Base
	has_many :trades
end

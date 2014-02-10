json.array!(@trades) do |trade|
  json.extract! trade, :id, :action, :status, :price, :shares, :date_posted, :stock_id
  json.url trade_url(trade, format: :json)
end

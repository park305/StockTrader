json.array!(@stocks) do |stock|
  json.extract! stock, :id, :symbol, :cost, :shares
  json.url stock_url(stock, format: :json)
end

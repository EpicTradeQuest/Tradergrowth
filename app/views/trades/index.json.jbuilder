json.array!(@trades) do |trade|
  json.extract! trade, :id, :result, :description
  json.url trade_url(trade, format: :json)
end

json.array!(@legacies) do |legacy|
  json.extract! legacy, :id, :title, :content, :number
  json.url legacy_url(legacy, format: :json)
end

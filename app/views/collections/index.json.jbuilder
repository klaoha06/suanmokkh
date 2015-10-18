json.array!(@collections) do |collection|
  json.extract! collection, :id, :book_id, :related_book_id
  json.url collection_url(collection, format: :json)
end

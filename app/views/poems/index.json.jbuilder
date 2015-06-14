json.array!(@poems) do |poem|
  json.extract! poem, :id
  json.url poem_url(poem, format: :json)
end

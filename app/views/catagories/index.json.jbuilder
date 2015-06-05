json.array!(@catagories) do |catagory|
  json.extract! catagory, :id
  json.url catagory_url(catagory, format: :json)
end

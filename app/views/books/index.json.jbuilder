json.array!(@books) do |book|
  json.extract! book, :id, :path, :cover_img, :downloads, :description, :title, :group, :isbn_10, :isbn_13, :language, :series, :publisher
  json.url book_url(book, format: :json)
end

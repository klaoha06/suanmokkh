json.array!(@retreat_talks) do |retreat_talk|
  json.extract! retreat_talk, :id, :name, :code
  json.url retreat_talk_url(retreat_talk, format: :json)
end

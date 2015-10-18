json.array!(@relationships) do |relationship|
  json.extract! relationship, :id, :retreat_talk_id, :related_retreat_talk_id, :create, :destroy
  json.url relationship_url(relationship, format: :json)
end

json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :title, :content, :name, :email, :tel, :reply
  json.url feedback_url(feedback, format: :json)
end

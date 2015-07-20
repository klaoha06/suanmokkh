require 'soundcloud'

Rails.application.config.after_initialize do
  # create client object with app and user credentials
  client = Soundcloud.new(:client_id => Rails.application.secrets.SC_CLIENT_ID,
                          :client_secret => Rails.application.secrets.SC_CLIENT_SECRET,
                          :username => Rails.application.secrets.SC_USERNAME,
                          :password => Rails.application.secrets.SC_PASSWORD)

  # print authenticated user's username
  puts Rails.application.secrets.SC_CLIENT_ID
  puts client.get('/me').username
end


# In Rails, you could put this in config/initializers/koala.rb
Koala.configure do |config|
  # config.access_token = MY_TOKEN
  # config.app_access_token = MY_APP_ACCESS_TOKEN
  config.app_id = "2255198964783302"
  config.app_secret = "5cc7c8c2e9da6569b44a555ba3d9e851"
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end

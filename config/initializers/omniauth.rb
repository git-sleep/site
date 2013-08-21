Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jawbone, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
end
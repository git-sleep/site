Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jawbone, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], {:provider_ignores_state => true}
end
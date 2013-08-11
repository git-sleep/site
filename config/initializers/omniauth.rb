Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jawbone, ENV['JAWBONE_CLIENT_ID'] =>{:provider_ignores_state => true}, ENV['JAWBONE_SECRET'] =>{:provider_ignores_state => true}
end
# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

if Rails.env.production?
  GitSleep::Application.config.secret_token = ENV['SECRET_TOKEN']
else
  GitSleep::Application.config.secret_token = 'b4b15af8356b5b3c6320f9695923dcbf'
end

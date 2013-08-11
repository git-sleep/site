class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :token, :xid
  
  def self.temporary_code_to_token(code)
    json = HTTParty.post(
      "https://jawbone.com/auth/oauth2/token",
      :body => {
        :client_id => ENV["JAWBONE_CLIENT_ID"],
        :client_secret => ENV["JAWBONE_SECRET"],
        :grant_type => "authorization_code",
        :code => code
      }
    ).body
    return JSON.parse(json)["access_token"]
  end

  def self.token_to_user_info(token)
    HTTParty.get(
      "https://jawbone.com/nudge/api/users/@me",
      :headers => {
        "Authorization" => "Bearer #{token}"
        }
    )["data"]
  end
  
end

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :token, :xid
  
  # def self.temporary_code_to_token(code)
  #   json = HTTParty.post(
  #     "https://jawbone.com/auth/oauth2/token",
  #     :body => {
  #       :client_id => ENV["JAWBONE_CLIENT_ID"],
  #       :client_secret => ENV["JAWBONE_SECRET"],
  #       :grant_type => "authorization_code",
  #       :code => code
  #     }
  #   ).body
  #   return JSON.parse(json)["access_token"]
  # end

  # def self.token_to_user_info(token)
  #   HTTParty.get(
  #     "https://jawbone.com/nudge/api/users/@me",
  #     :headers => {
  #       "Authorization" => "Bearer #{token}"
  #       }
  #   )["data"]
  # end
  
  def self.find_with_omniauth(auth)
    where(:provider => auth['provider'], :uid => auth['uid']).first
  end

  def self.create_from_omniauth(auth, student)
    student.update_from_omniauth(auth)
    identity_attributes = {uid: auth['uid'], provider: auth['provider']}
    case auth['provider']
    when 'github'
      identity_attributes.merge!(:auth_token => auth.credentials.token)
    end
    student.identities.create(identity_attributes)
  end

  def self.find_or_create_from_omniauth(auth, student = nil)
    # if an identity with this auth details exists, just return the student
    Identity.find_with_omniauth(auth) || (Identity.create_from_omniauth(auth, student) if student)
  end

end

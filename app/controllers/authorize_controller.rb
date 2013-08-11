class AuthorizeController < ApplicationController
  # def welcome
  #   # session.clear
  #   if session[:user_id]
  #     @user = User.find session[:user_id]
  #     unless @user
  #     @user = User.new(:token => token)
  #     user_info = HTTParty.get(
  #       "https://jawbone.com/nudge/api/users/@me",
  #       :headers => {
  #         "Authorization" => "Bearer #{token}"
  #         }
  #     )["data"]
  #     @user.first_name = user_info["first"]
  #     @user.last_name  = user_info["last"]
  #     @user.xid        = user_info["xid"]
  #     @user.photo      = user_info["image"]
  #     @user.save
  #     session[:user_id] = @user.id
  #   end
  #   redirect_to root_path
  # end

# def omniauth
#     auth = request.env["omniauth.auth"]
#     @user = User.find_or_create_from_omniauth(auth)
#   end
  # def auth
  #   # need to find by xid instead of token
  #   # even though tokens change, they can still
  #   # be used I think... test later
  #   json = HTTParty.post(
  #     "https://jawbone.com/auth/oauth2/token",
  #     :body => {
  #       :client_id => ENV["JAWBONE_CLIENT_ID"],
  #       :client_secret => ENV["JAWBONE_SECRET"],
  #       :grant_type => "authorization_code",
  #       :code => params[:code]
  #     }
  #   ).body
  #   token = JSON.parse(json)["access_token"]
  #   # raise token.inspect
  #   @user = User.find_by_token token
  #   unless @user
  #     @user = User.new(:token => token)
  #     user_info = HTTParty.get(
  #       "https://jawbone.com/nudge/api/users/@me",
  #       :headers => {
  #         "Authorization" => "Bearer #{token}"
  #         }
  #     )["data"]
  #     @user.first_name = user_info["first"]
  #     @user.last_name  = user_info["last"]
  #     @user.xid        = user_info["xid"]
  #     @user.photo      = user_info["image"]
  #     @user.save
  #     session[:user_id] = @user.id
  #   end
  #   redirect_to root_path
  # end
def create
  user = User.from_omniauth(env["omniauth.auth"])
  session[:user_id] = user.id
  redirect_to root_url, notice: "Signed in!"
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, notice: "Signed out!"
end

 #  def logout
 #    session[:user_id] = nil
 #    redirect_to root_path, notice: "Logged out!"
 #  end
 # end
end

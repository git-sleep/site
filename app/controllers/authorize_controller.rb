class AuthorizeController < ApplicationController

  def welcome
    if session[:user_id]
      @user = User.find session[:user_id]
    end
  end

  def auth
  
    auth = request.env["omniauth.auth"] 
     
    token = User.temporary_code_to_token(params[:code])
    user_info = User.token_to_user_info(token)
    
    @user = User.find_or_create_by_xid(user_info["xid"])
    @user.token = token
    @user.photo = user_info["image"]
    @user.first_name = user_info["first"]
    @user.last_name = user_info["last"]
    @user.save
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
 
end

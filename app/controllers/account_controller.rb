class AccountController < ApplicationController
  def login
    if request.post?
      session[:user] = nil
      if @user = User.authenticate(params[:username],params[:password])
        self.logged_in_user= @user
        redirect_to home_path
      else
        flash[:error] = "Username/Password was error!"
        redirect_to home_path
      end
    end
  end
  def logout
    reset_session
    flash[:notice] = "You have log out"
    redirect_to home_path 
  end
end

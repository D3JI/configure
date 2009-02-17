class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.create(params[:user])
    if @user.save!
      flash[:notice] = "User was successfully created"
      redirect_to home_path
    else
      flash[:error] = "Error!#{ @user.username }"
      redirect_to home_path
    end
  end
end

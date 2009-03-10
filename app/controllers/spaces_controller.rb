class SpacesController < ApplicationController
  layout 'users'
  def userstyle
    @user = User.find(logged_in_user)
    @style = Style.find_by_user_id(@user)
  end
  def set_style
    @user = logged_in_user
    @user.style.update_attributes(:stylename => params[:stylename]) unless @user.style.stylename== params[:stylename]
    redirect_to :action => "userstyle"
  end

  def usermodel
    @user = logged_in_user
    @usermodel = @user.usermodels
  end

  def set_model
    @user = logged_in_user
  end

  def edit
    @space = Space.find(params[:id])
    @user = @space.user
  end

  def update
    @space = Space.find(params[:id])
    if params[:space][:composition]
      if @space.update_attributes(params[:space][:composition])
        redirect_to control_path(:user_id => @space.user)
      end
    else
      redirect_to :action => 'edit', :id => @space.id
    end
  end

  def select_layout
    if params[:resolution]=="1024*768"
      render :partial => "layout5"
    else
      render :partial => "layout3"
    end
  end

end

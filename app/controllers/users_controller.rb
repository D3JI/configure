class UsersController < ApplicationController
  #  Information.content_columns.each do |c|
  #   in_place_edit_for :information, c.name
  # end

  #before_filter :add_space, :only => :create
  def index
    @user = User.find(logged_in_user)
    @users = User.find(:all, :order => 'created_at DESC', :conditions => ["id != ?", @user])
  end
  def home
    @user = User.find(params[:user_id])
    @categories = EntryCategory.find(:all)
    @entries = @user.entries.find(:all, :order => 'created_at DESC')
    @galleries = @user.galleries.find(:all, :order => 'created_at DESC')
    @friends = @user.friendships
  end
  def new
    @user = User.new
  end
  def create
    @user = User.create(params[:user])
    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to home_path(:user_id => @user.id)
    else
      render :action => 'new'
    end
  end
  def show
    #    @user = User.find(params[:user_id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    case params[:modify]
    when 'pwd'
      if User.change_password?(@user.username,params[:user])
        flash[:notice] = "Password Changed"
        render :action => 'edit'
      else
        flash[:error] = "当前密码错误"
        redirect_to :action => "edit"
      end
    end
  end

  def destroy
  end
  private
  #在用户注册成功之后,给用户的空间里赋默认值.
  def add_space
    @spacelocal = "hi" + request.url.to_s + params[:user][:username].to_s
    @process = Process.create(:address => @spacelocal,
                              :spacename => params[:user][:nike],
                              :spaceprofile => params[:user][:nike])
  end
end

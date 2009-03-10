class AccountController < ApplicationController
  layout "users"
  before_filter :before_logout, :only => [ :logout]

  def index
    @user = logged_in_user
    @recent_users = User.find(:all, :order => 'created_at DESC', :limit => 6, :conditions => ['id != :user', { :user => @user}])
    @friends = @user.friendships
    #@categories = Category.find(:all, :conditions => {:parent_id => nil}, :order => 'name desc')
    @activities = Activity.find(:all, :limit => 2,:order => 'created_at DESC',
                                :conditions => {:user_id => [@friends.id]})
    #@visits = Visit.find_all_by_guest_id(@user, :order => 'created_at DESC', :limit => 4)
    @visits = Visit.find_by_sql ["SELECT *, count(DISTINCT user_id) FROM visits WHERE guest_id = ? AND user_id != ? GROUP BY user_id ORDER BY created_at desc", @user, @user]
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def edit
    @user = User.find(params[:id])
   # @resolutions = Resolution.find(:all)
  end
  def login

    if request.post?
      reset_session
      if @user = User.authenticate(params[:username],params[:password])
        self.logged_in_user= @user
        redirect_to userhome_path(:user_id => @user.id)
      else
        flash[:error] = "用户名/密码错误!"
      end
    end
  end
  def logout
    reset_session
    flash[:notice] = "你已经退出了"
    redirect_to login_path
  end

  def type_show
    @entries = Entry.find_all_by_user_id(params[:id])
    #@types = Composition.find_all_by_process_id(params[:id])
    #render :text => "#{@types}"
  end

  private
  def before_logout
    logged_in_user.update_attribute(:last_activity, "On line")
    logged_in_user.update_attribute(:last_activity_at, Time.now)
  end
  def online?
    !User.find(:first, :conditions => ["user_id = ? and updated_at >= ?", id, Time.now - 10.minutes]).nil?
  end
end

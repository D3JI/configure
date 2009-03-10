class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include LoginSystem

  after_filter :recent_visit
  #before_filter :update_activity_time, :except => :session_expiry
  #before_filter :session_expiry, :except => [:update_activity_time, :recent_visit]
  protect_from_forgery  :secret => 'e450e01c269274a0c42693305c37db44'
  def recent_visit
    if is_logged_in?
      if logged_in_user.id != session[:user]
      visit = Visit.new
      visit.user_id = logged_in_user.id
      visit.guest_id = params[:user_id]
      visit.url = request.url
      visit.save!
      end
    end
  end
  def update_activity_time
    session[:expires_at] = session[:created_at]
  end
  def session_expiry
    if is_logged_in?
     @time_left = (Time.now - session[:updated]).to_i
    #  @time_left = (session[:expires_at] - Time.now).to_i   ||||| 86400秒= 一天
      if @time_left > 1000000000
        reset_session
        flash[:waring] = "您已经登录超时了.请重新登录"
        redirect_to login_path
      end
    end
  end
end

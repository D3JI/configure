module LoginSystem
  protected

  def is_logged_in?
    @logged_in_user = User.find(session[:user]) if session[:user]
  end

  def logged_in_user
    @logged_in_user if is_logged_in?
  end

  def logged_in_user=(user)
    if !user.nil?
      session[:user] = user.id
      @logged_in_user =user
    end
  end
  def self.included(base)
    base.send :helper_method, :is_logged_in?, :logged_in_user, :check_administrator_role, :has_role_admin?
  end
  def check_role(role)
    unless is_logged_in? && logged_in_user.has_role?(role)
      flash[:error] = "权限问题，请与管理员联系！"
      redirect_to login_path
    end
  end

  def check_administrator_role
    check_role('administrator')
  end
  def has_role_admin?
    if is_logged_in?
      logged_in_user.has_role?('administrator')
    end
  end
  def login_required
    unless is_logged_in?
      flash[:error] = "请先登录"
      redirect_to login_path
    end
  end
end

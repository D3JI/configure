class ShopsController < ApplicationController
  # GET /shops
  # GET /shops.xml
  layout 'users'
  def index
    @shops = Shop.find(:all)
    render :layout => 'admin'
  end

  # GET /shops/1
  # GET /shops/1.xml
  def show
    @user = User.find(params[:user_id])
    @shop = Shop.find(params[:id])
    redirect_to user_shop_products_path(:user_id => @user, :shop_id => @shop)
  end

  # GET /shops/new
  # GET /shops/new.xml
  def new
    @shop = Shop.new
    @user = User.find(params[:user_id])
   # @categories =Category.find(:all, :conditions => { :parent_id => nil})
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
    @user = User.find(params[:user_id])
  end

  # POST /shops
  # POST /shops.xml
  def create
    @user = User.find(params[:user_id])
    @shop = Shop.new(params[:shop])
    @shop.user = @user
    @shop.status = 1
    respond_to do |format|
      if @shop.save
        flash[:notice] = "您的店铺己激活#{params[:category_id]}=shop#{params[:shop][:category_id]}。"
        format.html { redirect_to control_path(:user_id => @shop.user) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /shops/1
  # PUT /shops/1.xml
  def update
    @shop = Shop.find(params[:id])
    @user = @shop.user
    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        flash[:notice] = 'Shop was successfully updated.'
        format.html { redirect_to userhome_path(:user_id => @user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.xml
  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to(admin_shops_url) }
      format.xml  { head :ok }
    end
  end

  def set_status
    @shop = Shop.find(params[:id])
    if @shop.status == 1
      @shop.update_attributes(:status => 0)
    else
      @shop.update_attributes(:status => 1)
    end
    redirect_to admin_shops_path
  end

  def set_recomend
    @shop = Shop.find(params[:id])
    if @shop.is_recomend == true
      @shop.update_attributes(:is_recomend => false)
    else
      @shop.update_attributes(:is_recomend => true)
    end
    redirect_to admin_shops_path
  end

  def select_with_parent_id
    if params[:parent_id]
      @children = Category.find_all_by_parent_id(params[:parent_id], :conditions => {:belongs_to => "shop"})
    end
    render :layout => false
  end

end


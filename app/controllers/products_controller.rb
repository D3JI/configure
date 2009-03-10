class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  layout 'users'
  def index
    @user = User.find(params[:user_id])
    @shop = Shop.find(params[:shop_id])
    @products = @shop.products

  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @categories = Category.find(:all, :conditions => {:parent_id => nil})
    @category = Category.find(params[:id])
    @product = Product.find(params[:id])
    render :layout => 'doc'
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @photo = Photo.new
    @product = Product.new
    @user = User.find(params[:user_id])
    @shop= Shop.find(params[:shop_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @user = User.find(params[:user_id])
    @shop = Shop.find(params[:shop_id])
    @product = Product.new(params[:product])
    @product.shop = @shop
    @photo = Photo.new(params[:photo])
    @photo.product = @product
    @photo.save
    #  @product.category_id = 1 unless params[:category_id]
    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to user_shop_products_path(:user_id => @user, :shop_id => @product.shop) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to user_shop_products_path(:user_id => params[:user_id], :shop_id => params[:shop_id]) }
      format.xml  { head :ok }
    end
  end
  def more_photo
    @product = Product.find(params[:id])
    @photo = Photo.new(params[:photo])
    @photo.product = @product
    @photo.save
    redirect_to user_shop_products_path(:user_id => params[:user_id], :shop_id => params[:shop_id])

  end
end


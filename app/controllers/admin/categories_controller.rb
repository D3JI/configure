class Admin::CategoriesController < ApplicationController
  layout "admin"
  def select_with_ajax
    if params[:parent_id]
    @children = Category.find_all_by_parent_id(params[:parent_id]).map{|c| [c.name,c.id]}
    else
    @children = Category.find(:all)
    end
    render :partial => params[:partial]
  end

  def index
    @categories = Category.find(:all, :conditions => {:parent_id => nil}, :order => "name desc")
  end

  def listpage

  end
  def show
    @categories =Category.find(:all, :conditions => {:parent_id => nil})
    @category = Category.find(params[:id])
    if @category.parent_id.nil?
    @products = Product.find(:all, :conditions => "category_parent=#{@category.id}")
    else
      @products = Product.find(:all, :conditions => "category_id=#{@category.id}")
    end
    render :layout => 'doc'
  end

  def new
    @categories = Category.find(:all, :conditions => {:parent_id => nil}, :order => "name desc")
    @category = Category.new
  end

  def edit
    @categories = Category.find(:all, :conditions => {:parent_id => nil}, :order => "name desc")
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "添加分类成功#{params[:type]}"
      redirect_to admin_categories_path
    end

  end

  def update
    @category = Category.find(params[:id])
    if  @category.update_attributes(params[:category])
      flash[:notice] =  "修改成功"
    end
    redirect_to admin_categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    if @category
      @category.destroy
      flash[:notice] = "#{@category.name} 被删除！"
    else
      flash[:notice] = "删除#{@category.name}失败！"
    end
      redirect_to admin_categories_path
  end
end

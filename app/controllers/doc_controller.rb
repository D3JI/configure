class DocController < ApplicationController
  def index
    @parent_categories = Category.find(:all, :conditions => {:parent_id => nil})
  end
  def listpage
    @parent_categories = Category.find(:all, :conditions => {:parent_id => nil})

    @category = Category.find_by_name(params[:name])
  end

  def show
    @parent_categories = Category.find(:all , :conditions => {:parent_id => nil})
    @product = Product.find(params[:id])
    @category = @product.category
  end
end


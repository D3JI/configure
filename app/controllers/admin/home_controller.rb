class Admin::HomeController < ApplicationController
  layout "admin"
  def index
    @users = User.find(:all, :order => 'username desc')
  end
  def all_products
    @products = Product.find(:all, :order => 'name')
  end
end

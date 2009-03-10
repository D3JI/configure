class Category < ActiveRecord::Base
  has_many :products
  has_many :shops
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id', :dependent => :delete_all
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'

  def product_children
    if self.children.empty?
      product_children = Category.find_all_by_parent_id(self.parent_id, :conditions => ["belongs_to = ?","product"])
    else
      produt_children = Category.find_all_by_parent_id(self.id, :conditions => ["belongs_to = ?", "product"])
    end
  end
  def shop_children
    if self.children.empty?
      shop_children = Category.find_all_by_parent_id(self.parent_id, :conditions => [ "belongs_to = ?", "shop"])
    else
      shop_children =Category.find_all_by_parent_id(self.id, :conditions => [ "belongs_to = ?", "shop"])
    end
  end
  def recomend_shops
    Shop.find_all_by_category_id(self.id)
  end
  def products_with_category
    Product.find_all_by_category_id(self.id)
  end

  def all_products
    if self.children.empty?
      Product.find_all_by_category_id(self.id)
    else
      Product.find_all_by_category_id(self.children)
    end
  end

end


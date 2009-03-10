class Shop < ActiveRecord::Base
  validates_presence_of :shopname, :category_id, :surename, :IDcard, :email, :phone, :address
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_length_of :phone, :in => 7..32
  validates_uniqueness_of :shopname, :IDcard, :email

  belongs_to :user
  belongs_to :category, :counter_cache => true
  has_many :products, :dependent => :destroy
  has_many :photos

  def show_status
    if self.status == 1
  %(已激活)
    else
  %(未激活)
    end
  end

  def show_recomend
    if self.is_recomend == 1 or self.is_recomend == true
  %(推荐)
    else
  %(不推荐)
    end
  end
end

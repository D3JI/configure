class Gallery < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :photos, :dependent => :destroy
  has_one :primary, :class_name => 'Photo', :conditions =>["photos.primary = ?",1]
end

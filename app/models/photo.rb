require 'RMagick'
class Photo < ActiveRecord::Base
  include ActivityLogger
#  acts_as_taggable
  belongs_to :shop
  belongs_to :product
  belongs_to :gallery, :counter_cache => true
  belongs_to :user, :counter_cache => true
  has_many :comments, :dependent => :destroy
  has_many :activities, :foreign_key => 'item_id', :dependent => :destroy
  has_attachment :storage => :file_system,
    :max_size => 5.megabytes,
    :content_type => :image,
    :thumbnails => { :tiny => '60x60>', :thumb => '100x100>' },
    :processor => :Rmagick
  #after_save :log_activity
  #  validates_as_attachment
  def log_activity
    #activity = Activity.create!(:item => self, :user => self.user_id)
    #add_activities(:activity => activity, :user => self.user_id)
    add_activities(:item => self, :user => self.user_id)
  end
end

class Entry < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :entry_category, :counter_cache => true
  belongs_to :user, :counter_cache => true
  validates_length_of :title, :within => 3..100
  validates_length_of :content , :maximum => 1000
end

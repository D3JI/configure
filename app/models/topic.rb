class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum, :counter_cache => true
  belongs_to :topic_category
  has_many :posts, :dependent => :destroy
end

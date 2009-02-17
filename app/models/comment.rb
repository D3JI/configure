class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry, :counter_cache => true
  validates_length_of :content, :maximum => 500
end

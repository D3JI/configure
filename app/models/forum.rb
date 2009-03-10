class Forum < ActiveRecord::Base
  has_many :topic_categories, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  has_many :posts, :through => :topics
  belongs_to :user

  def recent_topic
     recent_topic = Post.find(:last).tiopc
  end

end

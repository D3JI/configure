class TopicCategory < ActiveRecord::Base
  belongs_to :forum
  has_many :topics, :dependent => :destroy
end

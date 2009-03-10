class Event < ActiveRecord::Base
  has_and_belongs_to_many :user
  belongs_to :event_category
  belongs_to :events_users
end

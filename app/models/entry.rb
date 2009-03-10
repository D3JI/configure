class Entry < ActiveRecord::Base
  include ActivityLogger
  acts_as_taggable
  has_many :activities, :foreign_key => 'item_id', :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :entry_category, :counter_cache => true
  belongs_to :user, :counter_cache => true
  validates_length_of :title, :within => 3..100
  validates_length_of :content , :maximum => 1000
  after_create :log_activity
  #  def after_create
  #   self.user.update_attribute(:last_activity, "Create a New Entry")
  #  self.user.update_attribute(:last_activity_at, Time.now)
  #end
  def log_activity
    add_activities(:item => self, :user => self.user)
  end


 #3 namespace :db do  
  #  namespace :sessions do
  #    desc "Agide rake db:sessions:timeclear DAY=1  :Clear the sessions table where update before N day"
  #    task :timeclear => :environment do
  #      d = (ENV['DAY']).to_i
  #      session_table = 'entry'
  #      session_table = Inflector.pluralize(session_table) if ActiveRecord::Base.pluralize_table_names
  #      sql = "DELETE FROM #{session_table} where updated_at <= \'#{d.days.ago.to_s(:db)}\'"
  #      puts "Run"
  #      puts sql
  #      ActiveRecord::Base.connection.execute sql
  #    end
  #  end
  #end
end

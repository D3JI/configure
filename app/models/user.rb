class User < ActiveRecord::Base
  after_create :add_space
  MESSAGES_PER_PAGE = 5
  TRASH_TIME_AGO = 1.month.ago
  #  belongs_to :work
  has_and_belongs_to_many :events
  belongs_to :events_users
  has_many :forums
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_one :shop
  has_one :space
  has_one :style
  has_many :usermodels
  has_many :activities, :order => 'activities.created_at DESC',
    :limit => 3,
    :include => :user
  has_many :visits
  has_many :messages
  has_many :friendships
  has_many :friends, :through => :friendships, :class_name => 'User'
  has_many :informations
  has_one :avatar, :class_name => 'Photo', :conditions =>["photos.avatar = ?",1]
  has_many :galleries, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :boards, :dependent => :destroy
  has_many :entries, :dependent => :destroy, :extend => TagCountsExtension
  validates_presence_of :username, :email, :nike
  validates_length_of :username,:within => 3..10
  validates_length_of :nike, :within => 3..10
  validates_uniqueness_of :username, :email, :nike
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  attr_accessor :password_confirmation,:oldpassword, :new_password
  validates_confirmation_of :password
  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if @password.blank?
    create_a_salt
    self.hashed_password = User.encrypt_password(self.password,self.salt)
  end
  def self.authenticate(username, password)
    if user = self.find_by_username(username)
      correct_password = encrypt_password(password, user.salt)
      if user.hashed_password != correct_password
        user = nil
      end
    end
    user
  end

  def has_shop?
    unless self.shop.nil?
      if self.shop.status == 1
        return self.shop
      else
        false
      end
    end
  end

  def self.change_password?(username,passwords)
    @user = User.find_by_username(username)
    if @user.hashed_password == encrypt_password(passwords[:oldpassword],@user.salt)
      if passwords[:new_password] == passwords[:password_confirmation]
        @user.update_attributes(:password => passwords[:new_password])
      end
    else
      return false
    end
  end
  def before_destroy
    self.user.update_attribute(:last_activity, "Come")
    self.user.update_attribute(:last_activity_at, Time.now)
  end
  private
  def create_a_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  def self.encrypt_password(password,salt)
    string_to_hash = password + "mimimama" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  def add_space
    #@set = Set.new
    @usermodel = self.usermodels.create
    @style = Style.create(:user_id => self.id,
                           :stylename => "style001")

    @space = Space.create(:user_id => self.id, :address => "hi,mimimama.com/#{self.username}",
                          :titlee => self.nike,
                            :description => self.nike,
                            :resolution => "800*600",
                            :composition => "layout1")
  end
end

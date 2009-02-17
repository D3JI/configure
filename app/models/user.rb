class User < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :entries, :dependent => :destroy
  validates_presence_of :username, :email, :nike
  validates_length_of :username,:within => 3..10
  validates_length_of :nike, :within => 3..10
  validates_uniqueness_of :username, :email, :nike
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  attr_accessor :password_confirmation
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
  private
  def create_a_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  def self.encrypt_password(password,salt)
    string_to_hash = password + "mimimama" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end

class HomeController < ApplicationController
  #def index
  # @user = User.find(params[:user_id])
  # @categories = EntryCategory.find(:all)
  # @entries = @user.entries.find(:all, :order => 'created_at DESC')
  # @galleries = @user.galleries.find(:all, :order => 'created_at DESC')
  # @friends = @user.friendships
  #end

  def index
    @categories = Category.find(:all, :conditions => {:parent_id => nil}, :order => 'name desc')
    @forum_marry = Forum.find(1)
    @entries = Entry.find(:all, :order => 'created_at desc', :limit => 6)
  end
end

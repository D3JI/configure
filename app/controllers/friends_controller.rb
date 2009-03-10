class FriendsController < ApplicationController
  layout "users"
  def index
    #@user = User.find(params[:user_id], :include => [:friendships => :friend])
    @user = User.find(params[:user_id])
    @friends = @user.friendships
  end
  def new
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    unless @user.friends.include?(@friend)
      @friendship = @user.friendships.create(:friend_id => @friend.id)
    end
    redirect_to user_friends_path(:user_id => @user.id)
  end
  def destroy
    @user =  User.find(logged_in_user)
    @friendship = @user.friendships.find_by_friend_id(params[:id]).destroy
    redirect_to user_friends_path(:user_id => logged_in_user.id)
  end
end

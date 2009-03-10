class ForumsController < ApplicationController
  def index
    @forums = Forum.find(:all, :order => 'title')
    @topics = Topic.find(:all, :limit => 10, :order => 'created_at desc')
    @posts = Post.find(:all, :limit => 10, :order => 'created_at desc')
  end
end

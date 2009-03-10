class PostsController < ApplicationController
  layout 'forums'
  def index
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts
  end

  def new
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @forum = Forum.find(params[:forum_id])
    @post = logged_in_user.posts.new(params[:post])
    @post.topic = @topic
    @post.save
    redirect_to forum_topic_posts_path(:forum_id => @forum.id, :topic_id =>@topic.id)
  end
end

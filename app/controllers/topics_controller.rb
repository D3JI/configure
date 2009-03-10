class TopicsController < ApplicationController
  layout 'forums'
  def index
    @forum = Forum.find(params[:forum_id])
    @topics = @forum.topics 
  end

  def new
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.new
  end

  def create
    @forum = Forum.find(params[:forum_id])
    @topic = logged_in_user.topics.new(params[:topic])
    @topic.forum = @forum
    @topic.save
    redirect_to forum_topic_posts_path(:forum_id => @forum.id, :topic_id => @topic.id)
  end
  def show
    redirect_to forum_topic_posts_path(:forum_id => params[:forum_id], :id => params[:id])
  end

end

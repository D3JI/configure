class EventsController < ApplicationController
  def index
    @eventcategories = EventCategory.find(:all)
    @recent_events = Event.find(:all, :order => 'created_at DESC', :limit => 3)
    @official_events = Event.find(:all, :conditions => {:status => nil}, :limit => 3)
  end

  def new
    @event = Event.new
  end

  def create
    @event = logged_in_user.events.new(params[:event])
    if @event.save
      redirect_to  events_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @eventcategories = EventCategory.find(:all)
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @events_users = EventsUsers.find_all_by_event_id_and_user_id(@event,logged_in_user)
    if @events_users.empty?
    @event_user = EventsUsers.new(params[:events_users])
    @event_user.user_id = logged_in_user.id
    @event_user.event_id = @event.id
    @event_user.save
    end
    redirect_to :action => 'edit', :id => @event
  end

end

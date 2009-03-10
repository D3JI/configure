class GalleriesController < ApplicationController
  layout "users"
  #before_filter :after_save, :only => [:destroy]
  # GET /galleries
  def index
    @user = User.find(params[:user_id])
    @galleries = @user.galleries.find(:all)
    #@photos_count = Photo.find_all_by_user_id(@user)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galleries }
    end
  end

  # GET /galleries/1
  def show
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # GET /galleries/new
  def new
    @user = User.find(params[:user_id])
    @gallery = @user.galleries.new
  end

  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
  end

  # POST /galleries
  def create
    @user = User.find(params[:user_id])
    @gallery = @user.galleries.new(params[:gallery])

    respond_to do |format|
      if @gallery.save
        flash[:notice] = 'Gallery was successfully created.'
        format.html { redirect_to user_galleries_path  }
        format.xml  { render :xml => @gallery, :status => :created, :location => @gallery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  def update
    @user = User.find(params[:user_id])
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        flash[:notice] = 'Gallery was successfully updated.'
        format.html { redirect_to user_galleries_path(:user_id => @user.id ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  def destroy
    @user = User.find(params[:user_id])
    @gallery = @user.galleries.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to user_galleries_path }
      format.xml  { head :ok }
    end
  end

  private
  def after_save
    self.user.update_attribute(:last_activity, "Create a New Gallery")
    self.user.update_attribute(:last_activity_at, Time.now)
  end
end

class PhotosController < ApplicationController # GET /photos
  layout "users"
  def index
    @user = User.find(params[:user_id])
    @gallery = @user.galleries.find(params[:gallery_id])
    @photos = @gallery.photos.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @comments = @photo.comments.find(:all)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  def create
    @user = User.find(params[:user_id])
    user_data = { :user_id => @user.id }
    @gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.new(params[:photo].merge(user_data))

    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to user_galleries_path(:user_id => @user.id) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to gallery_photos_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
  #Put set_primary_gallery_photo_path
  def set_primary
    @photo = Photo.find(params[:id])
    @user = User.find(params[:user_id])
    @gallery = @user.galleries.find(params[:gallery_id])
    @old_primary = @gallery.photos.select(&:primary?)

    respond_to do |format|
      if @photo.update_attributes(:primary => true)
        @old_primary.each { |p| p.update_attributes!(:primary => false) }
        format.html { redirect_to user_galleries_path(:user_id => @photo.user) }
      end
    end
  end

  # Put set_avatar_gallery_photo_path

  def set_avatar
    @photo = Photo.find(params[:id])
    @old_avatar = logged_in_user.photos.select(&:avatar?)

    respond_to do |format|
      if @photo.update_attributes(:avatar => true)
        @old_avatar.each { |p| p.update_attributes!(:avatar => false) }
        format.html { redirect_to user_galleries_path(:user_id => @photo.user) }
      end
    end
  end
  # DELETE /photos/1
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to gallery_photos_path }
      format.xml  { head :ok }
    end
  end
end

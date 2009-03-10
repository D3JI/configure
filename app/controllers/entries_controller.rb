class EntriesController < ApplicationController
  layout "users"
  # GET /entries
  def index
    @user = User.find(params[:user_id])
    @entries = @user.entries.find(:all)
  end

  # GET /entries/1.xml
  def show
    @user = User.find(params[:user_id])
    @entry = Entry.find(params[:id])
    @comments = @entry.comments.find(:all)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  def new
    @user = User.find(params[:user_id])
    @tags = @user.entries.tag_counts(:order => 'name')
    @categories = EntryCategory.find(:all)
    @entry = @user.entries.new
  end

  # GET /entries/1/edit
  def edit
    @user = User.find(params[:user_id])
    @entry = @user.entries.find(params[:id])
  end

  # POST /entries
  def create
    @user = User.find(params[:user_id])
    @entry = @user.entries.new(params[:entry])
    #@entry.tag_list += ',' + params[:tag][:name]
    #@entry.save
    respond_to do |format|
      if @entry.save
        flash[:notice] = 'Entry was successfully created.'
        format.html { redirect_to user_entries_path }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to user_entry_path(:id => @entry) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to user_entries_url }
      format.xml  { head :ok }
    end
  end
  def add_tag
    @entry = logged_in_user.entries.find(params[:id])
    @entry.tag_list += ' ' + params[:tag][:name]
    @entry.save
    @new_tag = @entry.reload.tags.last
  end
  def remove_tag
    @entry = logged_in_user.entries.find(params[:id])
    @tag_to_delete = @entry.tags.find(params[:tag_id])
    if @tag_to_delete
      @entry.tags.delete(@tag_to_delete)
    else
      render :nothing => true
    end
  end
end

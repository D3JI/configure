class EntriesController < ApplicationController
  # GET /entries
  def index
    @user = User.find(params[:user_id])
    @entries = @user.entries.find(:all)

     end

  # GET /entries/1.xml
  def show
    @user = User.find(params[:user_id])
    @entry = @user.entries.find(params[:id])
    @comments = @entry.comments.find(:all)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end
#dai yong
   # @user = User.find(params[:user_id])
    #@category = EntryCategory.find(params[:category_id])
    #@entries = @category.entries.find(:all, :conditions => ['user_id = ?', @user])
  

  def new
    @categories = EntryCategory.find(:all)
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  def create
    @user = User.find(params[:user_id])
    @entry = @user.entries.new(params[:entry])

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
end

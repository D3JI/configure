class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @entry = Entry.find(params[:entry_id])
    @comments = @entry.comments.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
  end

  
  # POST /comments
  # POST /comments.xml
  def create
    #@entry = Entry.find(params[:entry_id])
    #@comment = @entry.comments.new(params[:comment])
    @comment =  Comment.create(:entry_id => params[:entry_id], :user_id => params[:user_id], :content => params[:comment][:content])
    respond_to do |format|
      if @comment
        format.html { redirect_to user_entry_path(:id => @comment.entry_id) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to user_entry_path(:id => @entry.id) }
      format.xml  { head :ok }
    end
  end
end

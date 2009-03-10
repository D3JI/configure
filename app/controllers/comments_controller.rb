class CommentsController < ApplicationController
    in_place_edit_for :board, :reply
  # GET /comments
  def index
    @user = User.find(params[:user_id])
    @boards = Board.find_all_by_boarder_id(params[:user_id])
  end

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  def create
    user_data = { :user_id => params[:user_id] }
    case params[:switch]
    when 'entry'
      @entry = Entry.find(params[:entry_id])
      @comment = @entry.comments.create(params[:comment].merge(user_data))
      if @comment
        redirect_to user_entry_path(:id => @comment.entry_id, :user_id => @entry.user)
      end
    when 'photo'
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.create(params[:comment].merge(user_data))
      if @comment
        redirect_to gallery_photo_path(:id => @photo.id, :user_id => @photo.user)
      end
    when 'board'
      @board = Board.create(:boarder_id => params[:user_id],
                            :user_id => logged_in_user.id,
                            :content => params[:board][:content])
      if @board
        redirect_to user_comments_path(:user_id => @board.user)
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.entry_id.nil?
      @photo = Photo.find(params[:photo_id])
      @photo_comment = @photo.comments.find(params[:id])
      @photo_comment.destroy

      respond_to do |format|
        format.html { redirect_to gallery_photo_path(:id => @photo.id, :user_id => @photo.user) }
      end
    end
    if @comment.photo_id.nil?
      @entry = Entry.find(params[:entry_id])
      @entry_comment = @entry.comments.find(params[:id])
      @entry_comment.destroy
      respond_to do |format|
        format.html { redirect_to user_entry_path(:id => @entry.id, :user_id => @entry.user) }
      end
    end
  end
  def delete_board
    @board = Board.find(params[:id])
    @user = User.find(params[:user_id])
    @board.destroy
    redirect_to user_comments_path(:boarder_id => @board.boarder_id)
  end
end

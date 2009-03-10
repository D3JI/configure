class MessagesController < ApplicationController
  layout "users"
  def index
    @user = User.find(params[:user_id])
    @recipient_messages = Message.find_all_by_recipient_id(params[:user_id], :conditions => {:recipient_deleted_at => nil})
  end

  def new
    @user = User.find(logged_in_user)
    @recipient = User.find(params[:recipient_id])
    @message = Message.new()
  end

  def renew
    @current_message = Message.find(params[:id])
    @recipient = @current_message.sender
    @recipient_messages = Message.find_all_by_recipient_id(params[:user_id])
    @user = User.find(logged_in_user)
    @message = Message.new()
  end
  def reply
    @user = User.find(logged_in_user)
    @recipient_messages = Message.find_all_by_recipient_id(params[:user_id])
    @oldmessage = Message.find(params[:id])
    @message = Message.create(:parent_id    => @oldmessage.id,
                              :title      => @oldmessage.title,
                              :content => params[:message][:content],
                              :sender_id       => @user.id,
                              :recipient_id    => @oldmessage.sender_id)
    respond_to do |format|
      format.html { redirect_to messages_path(:user_id => logged_in_user.id) }
    end
  end
  def create
    @message = Message.create(:sender_id => logged_in_user.id,
                              :recipient_id => params[:recipient_id],
                              :title => params[:message][:title],
                              :content => params[:message][:content])
    if @message
      redirect_to messages_path(:user_id => logged_in_user.id)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_path(:user_id => logged_in_user)
  end

  def message_to
    @user = User.find(logged_in_user)
    @recipient_messages = Message.find_all_by_recipient_id(@user)
    @send_messages = Message.find_all_by_sender_id(params[:sender_id], :conditions => {:sender_deleted_at => nil})
  end
  def message_delete
    @user = User.find(logged_in_user)
    @recipient_messages = Message.find_all_by_recipient_id(@user)
    @message_delete = Message.find(params[:id])
    #if @messages_delete.untrash(logged_in_user)
    if @message_delete.sender == logged_in_user
      @message_delete.update_attributes(:sender_deleted_at => Time.now)
      flash[:success] = "邮件已经移到垃圾箱了"
    elsif
      @message_delete.recipient == logged_in_user
      @message_delete.update_attributes(:recipient_deleted_at => Time.now)
      flash[:success] = "邮件已经移到垃圾箱了"
    end
    respond_to do |format|
      format.html { redirect_to messages_url(:user_id => @user) }
    end
  end

  def trashbox
    @user = User.find(params[:user_id])
    @messages = Message.find(:all, :conditions => [ "(sender_deleted_at != 0 AND sender_id = :user) OR (recipient_id = :user AND recipient_deleted_at != 0)", {:user => @user}])
    @recipient_messages = Message.find_all_by_recipient_id(@user)
  end
end

class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => 'User', :foreign_key => 'recipient_id'

  # Put the message in the trash for the given person.
  def trash(person, time=Time.now)
    #case person
    #when sender
    if person.id ==self.sender_id
      self.sender_deleted_at = time
      #when recipient
    end
    if person.id == self.recipient_id
      self.recipient_deleted_at = time
    end
    save!
  end

  # Move the message back to the inbox.
  def untrash(user)
    # return false unless trashed?(user)
    trash(user, nil)
  end

  # Return true if the message has been trashed.
  def trashed?(person)
    case person
    when sender
      !sender_deleted_at.nil? and sender_deleted_at > User::TRASH_TIME_AGO
    when recipient
      !recipient_deleted_at.nil? and 
      recipient_deleted_at > User::TRASH_TIME_AGO
    end
  end
end

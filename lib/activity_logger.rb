module ActivityLogger

  def add_activities(options = {})
    user = options[:user]
    include_user = options[:include_user]
    activity = options[:activity] ||
      Activity.create!(:item => options[:item], :user => user)
    user_ids = people_to_add(user, activity, include_user)
  end

  private
  def people_to_add(user, activity, include_user)
    all = user.friendships.map(&:id)
    all.push(user.id) if include_user
  end

  def values(ids, common_value)
    common_values = [common_value] * ids.length
    convert_to_sql(ids.zip(common_values))
  end

  def convert_to_sql(array_of_values)
    array_of_values.inspect[1...-1].gsub('[', '(').gsub(']', ')')
  end
end

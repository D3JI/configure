# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
#  include TagsHelper
  #  def tag_cloud(tag_counts)
  #    ceiling = Math.log(tag_counts.max { |a,b| a.count <=> b.count }.count)
  #    floor = Math.log(tag_counts.min { |a,b| a.count <=> b.count }.count)
  #    range = ceiling - floor
  #    tag_counts.each do |tag|
  #      count = tag.count
  #      size=(((Math.log(count) - floor)/range)*66)+33
  #      yield tag, size
  #    end
  #  end
  def tag_cloud(tags, classes)
    max, min =0, 0
    tags.each do |tag|
      max = tag.count if tag.count > max
      min = tag.count if tag.count < min
    end

    divisor = ((max - min) / classes.size) + 1
    tags.each do |tag|
      yield tag.name, classes[(tag.count - min) / divisor ]
    end
  end
end

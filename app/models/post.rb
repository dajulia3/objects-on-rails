class Post
  #These mixins are needed in order to use rails forms w/Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :title, :body, :blog

  def initialize( attrs = {})
    attrs.each { |k,v| send("#{k}=", v) }
  end

  def publish
    blog.add_entry(self)
  end

  #For Rails to render the forms, we need this method
  def persisted?
    false
  end
end

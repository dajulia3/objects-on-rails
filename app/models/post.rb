require 'active_model'

class Post
  #These mixins are needed in order to use rails forms w/Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  validates :title, presence: true
  attr_accessor :title, :body, :blog, :image_url, :pubdate

  def initialize( attrs = {})
    attrs.each { |k,v| send("#{k}=", v) }
  end

  def publish(clock=DateTime)
    return false unless valid?
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  #For Rails to render the forms, we need this method
  def persisted?
    false
  end
end

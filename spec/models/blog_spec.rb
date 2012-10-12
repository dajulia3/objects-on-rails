require_relative '../../app/models/blog'
require 'ostruct'

describe Blog do
  subject{ Blog.new }
  it "has no entries" do
    subject.entries.should be_empty
  end

  describe "#new_post" do
    let(:new_post){ OpenStruct.new }
    before(:each){ subject.post_source = ->{ new_post } }

    it "returns a new post" do
      subject.new_post.should == new_post
    end

    it "sets the post's blog reference to itself" do
      subject.new_post.blog.should == subject
    end

    it "accepts an attribute hash on behalf of the post maker" do
      post_source = mock(:post_source)
      post_source.should_receive(:call).with({ x:42, y:'z' }).
                                             and_return(new_post)
      subject.post_source = post_source
      subject.new_post(x: 42, y:'z')
    end
  end

  describe "#add_entry" do
    it "should add the entry to the blog" do
      entry = Object.new
      subject.add_entry(entry)
      subject.entries.should include entry
    end
  end

end

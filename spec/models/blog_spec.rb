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
      entry = mock(:entry).as_null_object
      subject.add_entry(entry)
      subject.entries.should include entry
    end
  end

  describe "#entries" do
    def stub_entry_with_date(date)
      OpenStruct.new(pubdate: DateTime.parse(date))
    end

    it "should be sorted in reverse-chronological order" do
      oldest = stub_entry_with_date("2011-09-09")
      newest = stub_entry_with_date("2011-09-11")
      middle = stub_entry_with_date("2011-09-10")
      subject.add_entry(oldest)
      subject.add_entry(newest)
      subject.add_entry(middle)
      subject.entries.should == [newest, middle, oldest]
    end

    it "should be limited to 10 items" do
      10.times do |i|
        subject.add_entry(stub_entry_with_date("2011-09-#{i+1}"))
      end
      oldest = stub_entry_with_date("2011-08-30")
      subject.add_entry(oldest)
      subject.entries.size.should == 10
      subject.entries.should_not include oldest
    end
  end

end

require_relative '../spec_helper_lite'
require_relative '../../app/models/post'

describe Post do
  subject { Post.new }
  it "supports setting attributes in the initializer" do
    subject = Post.new(title: "mytitle", body: "mybody")
    subject.title.should == "mytitle"
    subject.body.should == "mybody"
  end

  it "should start with blank attributes" do
    subject.title.should be_nil
    subject.body.should be_nil
  end

  it "should support reading and writing a title" do
    subject.title = "foo"
    subject.title.should == "foo"
  end

  it "should support reading and writing a post body" do
    subject.body = "foo"
    subject.body.should == "foo"
  end

  it "should support reading and writing a blog reference" do
    blog = Object.new
    subject.blog = blog
    subject.blog.should == blog
  end

  describe "#publish" do
    let(:blog) { mock(:blog).as_null_object }
    before(:each) { subject.blog = blog }

    context "given an invalid post" do
      before(:each) { subject.title = nil }

      it "should not add the post to the blog" do
        subject.blog.should_not_receive :add_entry
        subject.publish
      end

      it "should return false" do
        subject.publish.should == false
      end
    end

    context "given a valid post" do
      before(:each) { subject.title = "My title" }
      it "should add the post to the blog" do
        blog.should_receive(:add_entry).with(subject)
        subject.publish
      end

      it "should return a truthy value" do
        subject.publish.should be_true
      end
    end
  end

  describe "#pubdate" do
    context "before publishing" do
      it "is blank" do
        subject.pubdate.should be_nil
      end
    end

    context "after publishing" do
      let(:clock) { mock(:clock) }
      let(:now) { DateTime.parse "2011-09-11T02:56" }

      before :each do
        subject.title = "Valid title"
        clock.stub(:now).and_return now
        subject.blog = double(:blog).as_null_object
        subject.publish(clock)
      end

      it "is a datetime" do
        subject.pubdate.class.should == DateTime
      end

      it "should be the current time" do
        subject.pubdate.should == now
      end
    end
  end

  it "should not be valid with a blank title" do
    [nil, "", " "].each do |bad_title|
      subject.title = bad_title
      subject.should_not be_valid
    end
  end

  it "should be valid with a non-blank title" do
    subject.title= "x"
    subject.should be_valid
  end

end

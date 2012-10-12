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
    let(:blog) { mock(:blog) }
    before(:each) { subject.blog = blog }
    
    it "should add the post to the blog" do
      blog.should_receive(:add_entry).with(subject)
      subject.publish
    end
  end
end

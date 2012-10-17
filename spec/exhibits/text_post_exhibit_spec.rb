require_relative '../../app/exhibits/text_post_exhibit'
require 'ostruct'
describe TextPostExhibit do
  let(:post) do
    OpenStruct.new(
        title:    "TITLE",
        body:     "BODY",
        pubdate:  "PUBDATE")
    end
  let(:context) { mock(:context).as_null_object }
  subject { TextPostExhibit.new(post, context) }

  it "should delegate method calls to the post" do
    subject.title.should == "TITLE"
    subject.body.should == "BODY"
    subject.pubdate.should == "PUBDATE"
  end

  it "should render itself with the appropriate partial" do
    context.stub(:render).with(partial: "/posts/text_body", locals: { post: subject }).and_return  "THE_HTML"
    subject.render_body.should == "THE_HTML"
  end
end

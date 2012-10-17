require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/picture_post_exhibit'
require 'ostruct'
describe PicturePostExhibit do
  let(:post) do
    OpenStruct.new(
        title:    "TITLE",
        body:     "BODY",
        pubdate:  "PUBDATE")
    end
  let(:context) { mock(:context).as_null_object }
  subject(:picture_post_exhibit) { PicturePostExhibit.new(post, context) }

  it "should delegate method calls to the post" do
    picture_post_exhibit.title.should == "TITLE"
    picture_post_exhibit.body.should == "BODY"
    picture_post_exhibit.pubdate.should == "PUBDATE"
  end

  it "should render itself with the appropriate partial" do
    context.stub(:render).with(partial: "/posts/picture_body", locals: { post: subject }).and_return  "THE_HTML"
    subject.render_body.should == "THE_HTML"
  end
end

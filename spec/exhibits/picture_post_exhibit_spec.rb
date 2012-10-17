require_relative '../../app/exhibits/picture_post_exhibit'
require_relative './post_exhibit_spec'
describe PicturePostExhibit do
  it_behaves_like "PostExhibit", 'picture_body', PicturePostExhibit
end

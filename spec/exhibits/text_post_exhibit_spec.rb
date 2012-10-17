require_relative '../../app/exhibits/text_post_exhibit'
require_relative './post_exhibit_spec'
describe TextPostExhibit do
  it_behaves_like "PostExhibit", 'text_body', TextPostExhibit
end

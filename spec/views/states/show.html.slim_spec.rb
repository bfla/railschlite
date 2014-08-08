require 'rails_helper'

RSpec.describe "states/show", :type => :view do
  before(:each) do
    @state = assign(:state, State.create!(
      :name => "Name",
      :abbrev => "Abbrev",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :hashtag => "Hashtag",
      :zoom => 1,
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Abbrev/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Hashtag/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Slug/)
  end
end

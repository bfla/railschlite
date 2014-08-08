require 'rails_helper'

RSpec.describe "cities/show", :type => :view do
  before(:each) do
    @city = assign(:city, City.create!(
      :state_id => 1,
      :name => "Name",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :zoom => 2,
      :slug => "Slug",
      :campsites_count => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/3/)
  end
end

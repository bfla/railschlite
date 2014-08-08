require 'rails_helper'

RSpec.describe "destinations/show", :type => :view do
  before(:each) do
    @destination = assign(:destination, Destination.create!(
      :state_id => 1,
      :name => "Name",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :zoom => 2,
      :radius => 3,
      :slug => "Slug",
      :highlights => "MyText",
      :things_to_do => "MyText",
      :camping_tips => "MyText"
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
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end

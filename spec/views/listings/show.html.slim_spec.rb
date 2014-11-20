require 'rails_helper'

RSpec.describe "listings/show", :type => :view do
  before(:each) do
    @listing = assign(:listing, Listing.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end

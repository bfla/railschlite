require 'rails_helper'

RSpec.describe "listings/index", :type => :view do
  before(:each) do
    assign(:listings, [
      Listing.create!(
        :name => "Name"
      ),
      Listing.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

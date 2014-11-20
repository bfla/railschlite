require 'rails_helper'

RSpec.describe "listings/edit", :type => :view do
  before(:each) do
    @listing = assign(:listing, Listing.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit listing form" do
    render

    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do

      assert_select "input#listing_name[name=?]", "listing[name]"
    end
  end
end

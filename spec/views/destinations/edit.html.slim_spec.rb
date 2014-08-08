require 'rails_helper'

RSpec.describe "destinations/edit", :type => :view do
  before(:each) do
    @destination = assign(:destination, Destination.create!(
      :state_id => 1,
      :name => "MyString",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :zoom => 1,
      :radius => 1,
      :slug => "MyString",
      :highlights => "MyText",
      :things_to_do => "MyText",
      :camping_tips => "MyText"
    ))
  end

  it "renders the edit destination form" do
    render

    assert_select "form[action=?][method=?]", destination_path(@destination), "post" do

      assert_select "input#destination_state_id[name=?]", "destination[state_id]"

      assert_select "input#destination_name[name=?]", "destination[name]"

      assert_select "textarea#destination_description[name=?]", "destination[description]"

      assert_select "input#destination_latitude[name=?]", "destination[latitude]"

      assert_select "input#destination_longitude[name=?]", "destination[longitude]"

      assert_select "input#destination_zoom[name=?]", "destination[zoom]"

      assert_select "input#destination_radius[name=?]", "destination[radius]"

      assert_select "input#destination_slug[name=?]", "destination[slug]"

      assert_select "textarea#destination_highlights[name=?]", "destination[highlights]"

      assert_select "textarea#destination_things_to_do[name=?]", "destination[things_to_do]"

      assert_select "textarea#destination_camping_tips[name=?]", "destination[camping_tips]"
    end
  end
end

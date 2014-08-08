require 'rails_helper'

RSpec.describe "states/new", :type => :view do
  before(:each) do
    assign(:state, State.new(
      :name => "MyString",
      :abbrev => "MyString",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :hashtag => "MyString",
      :zoom => 1,
      :slug => "MyString"
    ))
  end

  it "renders new state form" do
    render

    assert_select "form[action=?][method=?]", states_path, "post" do

      assert_select "input#state_name[name=?]", "state[name]"

      assert_select "input#state_abbrev[name=?]", "state[abbrev]"

      assert_select "textarea#state_description[name=?]", "state[description]"

      assert_select "input#state_latitude[name=?]", "state[latitude]"

      assert_select "input#state_longitude[name=?]", "state[longitude]"

      assert_select "input#state_hashtag[name=?]", "state[hashtag]"

      assert_select "input#state_zoom[name=?]", "state[zoom]"

      assert_select "input#state_slug[name=?]", "state[slug]"
    end
  end
end

require 'rails_helper'

RSpec.describe "cities/new", :type => :view do
  before(:each) do
    assign(:city, City.new(
      :state_id => 1,
      :name => "MyString",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :zoom => 1,
      :slug => "MyString",
      :campsites_count => 1
    ))
  end

  it "renders new city form" do
    render

    assert_select "form[action=?][method=?]", cities_path, "post" do

      assert_select "input#city_state_id[name=?]", "city[state_id]"

      assert_select "input#city_name[name=?]", "city[name]"

      assert_select "textarea#city_description[name=?]", "city[description]"

      assert_select "input#city_latitude[name=?]", "city[latitude]"

      assert_select "input#city_longitude[name=?]", "city[longitude]"

      assert_select "input#city_zoom[name=?]", "city[zoom]"

      assert_select "input#city_slug[name=?]", "city[slug]"

      assert_select "input#city_campsites_count[name=?]", "city[campsites_count]"
    end
  end
end

require 'rails_helper'

RSpec.describe "campsites/new", :type => :view do
  before(:each) do
    assign(:campsite, Campsite.new(
      :name => "MyString",
      :state => "MyString",
      :latitude => 1.5,
      :longitude => 1.5,
      :elevation => 1,
      :phone => 1,
      :total_sites => 1,
      :electric_sites => 1,
      :outhouse => false,
      :showers => false,
      :dump => false
    ))
  end

  it "renders new campsite form" do
    render

    assert_select "form[action=?][method=?]", campsites_path, "post" do

      assert_select "input#campsite_name[name=?]", "campsite[name]"

      assert_select "input#campsite_state[name=?]", "campsite[state]"

      assert_select "input#campsite_latitude[name=?]", "campsite[latitude]"

      assert_select "input#campsite_longitude[name=?]", "campsite[longitude]"

      assert_select "input#campsite_elevation[name=?]", "campsite[elevation]"

      assert_select "input#campsite_phone[name=?]", "campsite[phone]"

      assert_select "input#campsite_total_sites[name=?]", "campsite[total_sites]"

      assert_select "input#campsite_electric_sites[name=?]", "campsite[electric_sites]"

      assert_select "input#campsite_outhouse[name=?]", "campsite[outhouse]"

      assert_select "input#campsite_showers[name=?]", "campsite[showers]"

      assert_select "input#campsite_dump[name=?]", "campsite[dump]"
    end
  end
end

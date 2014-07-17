require 'rails_helper'

RSpec.describe "campsites/index", :type => :view do
  before(:each) do
    assign(:campsites, [
      Campsite.create!(
        :name => "Name",
        :state => "State",
        :latitude => 1.5,
        :longitude => 1.5,
        :elevation => 1,
        :phone => 2,
        :total_sites => 3,
        :electric_sites => 4,
        :outhouse => false,
        :showers => false,
        :dump => false
      ),
      Campsite.create!(
        :name => "Name",
        :state => "State",
        :latitude => 1.5,
        :longitude => 1.5,
        :elevation => 1,
        :phone => 2,
        :total_sites => 3,
        :electric_sites => 4,
        :outhouse => false,
        :showers => false,
        :dump => false
      )
    ])
  end

  it "renders a list of campsites" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end

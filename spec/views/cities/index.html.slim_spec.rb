require 'rails_helper'

RSpec.describe "cities/index", :type => :view do
  before(:each) do
    assign(:cities, [
      City.create!(
        :state_id => 1,
        :name => "Name",
        :description => "MyText",
        :latitude => 1.5,
        :longitude => 1.5,
        :zoom => 2,
        :slug => "Slug",
        :campsites_count => 3
      ),
      City.create!(
        :state_id => 1,
        :name => "Name",
        :description => "MyText",
        :latitude => 1.5,
        :longitude => 1.5,
        :zoom => 2,
        :slug => "Slug",
        :campsites_count => 3
      )
    ])
  end

  it "renders a list of cities" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end

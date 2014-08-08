require 'rails_helper'

RSpec.describe "destinations/index", :type => :view do
  before(:each) do
    assign(:destinations, [
      Destination.create!(
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
      ),
      Destination.create!(
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
      )
    ])
  end

  it "renders a list of destinations" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

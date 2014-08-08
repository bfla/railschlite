require 'rails_helper'

RSpec.describe "states/index", :type => :view do
  before(:each) do
    assign(:states, [
      State.create!(
        :name => "Name",
        :abbrev => "Abbrev",
        :description => "MyText",
        :latitude => 1.5,
        :longitude => 1.5,
        :hashtag => "Hashtag",
        :zoom => 1,
        :slug => "Slug"
      ),
      State.create!(
        :name => "Name",
        :abbrev => "Abbrev",
        :description => "MyText",
        :latitude => 1.5,
        :longitude => 1.5,
        :hashtag => "Hashtag",
        :zoom => 1,
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of states" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Abbrev".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Hashtag".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end

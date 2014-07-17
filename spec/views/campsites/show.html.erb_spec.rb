require 'rails_helper'

RSpec.describe "campsites/show", :type => :view do
  before(:each) do
    @campsite = assign(:campsite, Campsite.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end

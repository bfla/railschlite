require 'rails_helper'

RSpec.describe City, :type => :model do

  before { @city = FactoryGirl.create(:city) }
  subject { @city }

  describe "when new Campsite is created with valid inputs" do 
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:state_id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:state_abbrev) }
    it { is_expected.to respond_to(:state_hashtag) }
    it { is_expected.to respond_to(:latitude) }
    it { is_expected.to respond_to(:longitude) }
    it { is_expected.to respond_to(:zoom) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:slug) }
    it { is_expected.to respond_to(:campsites_count) }
    
  end

  # VALIDATIONS ==================================================================================

  # These really aren't so important because states rarely get added or changed and
  # only administrators can do it.

  describe "when name is missing" do
    before { @city.name = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when latitude missing" do
    before { @city.latitude = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when longitude is missing" do
    before { @city.longitude = nil }
    it { is_expected.not_to be_valid }
  end

  # RELATIONSHIPS TO OTHER MODELS ==================================================================================

  it "should relate to campsite" do
    @city.save
    @campsite = FactoryGirl.create(:campsite)
    @campsite.city_id = @city.id
    @campsite.save
    expect(@campsite.city.name).to eq @city.name
  end

  it "should count its campsites in the counter_cache" do
    @city.save
    @campsite = FactoryGirl.create(:campsite)
    @campsite.city_id = @city.id
    @campsite.save
    expect(@city.campsites_count).to eq 1
  end
end

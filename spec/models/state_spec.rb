require 'rails_helper'

RSpec.describe State, :type => :model do

  before { @state = FactoryGirl.create(:state) }
  subject { @state }

  describe "when new Campsite is created with valid inputs" do 
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:latitude) }
    it { is_expected.to respond_to(:longitude) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:abbrev) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:slug) }
    it { is_expected.to respond_to(:campsites_count) }
    it { is_expected.to respond_to(:hashtag) }
    it { is_expected.to respond_to(:zoom) }
  end

  # VALIDATIONS ==================================================================================

  # These really aren't so important because states rarely get added or changed and
  # only administrators can do it.

  describe "when name is missing" do
    before { @state.name = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when abbreviation is missing" do
    before { @state.abbrev = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when latitude missing" do
    before { @state.latitude = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when longitude is missing" do
    before { @state.longitude = nil }
    it { is_expected.not_to be_valid }
  end

  # RELATIONSHIPS TO OTHER MODELS ==================================================================================

  it "should relate to campsite" do
    @state.save
    @campsite = FactoryGirl.create(:campsite)
    @campsite.state_id = @state.id
    @campsite.save
    expect(@campsite.state_abbrev).to eq @state.abbrev
  end

  it "should count its campsites in the counter_cache" do
    @state.save
    @campsite = FactoryGirl.create(:campsite)
    @campsite.state_id = @state.id
    @campsite.save
    expect(@state.campsites_count).to eq 1
  end

  

end

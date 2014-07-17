require 'rails_helper'

RSpec.describe Campsite, :type => :model do
  before { @campsite = FactoryGirl.create(:campsite) }
  subject { @campsite }

  describe "when new Campsite is created with valid inputs" do 
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:state) }
    it { is_expected.to respond_to(:latitude) }
    it { is_expected.to respond_to(:longitude) }
    it { is_expected.to respond_to(:elevation) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:total_sites) }
    it { is_expected.to respond_to(:electric_sites) }
    it { is_expected.to respond_to(:outhouse) }
    it { is_expected.to respond_to(:showers) }
    it { is_expected.to respond_to(:dump) }

    it { is_expected.to respond_to(:to_json_v1) }
    it { is_expected.to be_valid }
  end

  # VALIDATIONS ==================================================================================

  describe "when name is missing" do
    before { @campsite.name = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when name is blank text" do
    before { @campsite.name = "" }
    it { is_expected.not_to be_valid }
  end

  describe "when latitude is missing" do
    before { @campsite.latitude = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when latitude is negative (Southern Hemisphere)" do
    before { @campsite.latitude = -45.12345 }
    it { is_expected.not_to be_valid }
  end  

  describe "when longitude is missing" do
    before { @campsite.longitude = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when longitude is in positive (Eastern Hemisphere)" do
    before { @campsite.longitude = 88.9123 }
    it { is_expected.not_to be_valid }
  end 

  describe "when elevation is not integer" do
    before {@campsite.elevation = "Hufflepuff"}
    it { is_expected.not_to be_valid }
  end

  describe "when phone is not integer" do
    before {@campsite.phone = "800-123-4567"}
    it { is_expected.not_to be_valid }
  end

  describe "when total_sites is not integer" do
    before {@campsite.total_sites = "One hundred"}
    it { is_expected.not_to be_valid }
  end

  describe "when outhouse is not boolean" do
    before {@campsite.total_sites = "Slitheren"}
    it { is_expected.not_to be_valid }
  end

  describe "when showers is not boolean" do
    before {@campsite.total_sites = "Ravenclaw"}
    it { is_expected.not_to be_valid }
  end

  describe "when dump is not boolean" do
    before {@campsite.total_sites = "Griffendor"}
    it { is_expected.not_to be_valid }
  end

  # API V1 METHODS ==============================================================================================
  describe "to_json_v1 method" do
    #before { cgjson = @campsite.to_json_v1 }
    #let(:attributes) { JSON.parse(cgjson) }

    describe "should return JSON object" do

    end

    describe "should return name for each campsite" do

    end

    describe "should return phone number" do
    end

    describe "should return latitude and longitude" do
    end

    describe "should return elevation" do
    end

    describe "should return showers, outhouse, and dump" do
    end

  end

end

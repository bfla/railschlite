require 'rails_helper'

RSpec.describe Campsite, :type => :model do
  before { @campsite = FactoryGirl.create(:campsite) }
  subject { @campsite }

  describe "when new Campsite is created with valid inputs" do 
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:state_abbrev) }
    it { is_expected.to respond_to(:city_name) }
    it { is_expected.to respond_to(:address) }
    it { is_expected.to respond_to(:latitude) }
    it { is_expected.to respond_to(:longitude) }
    it { is_expected.to respond_to(:elevation) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:total_sites) }
    it { is_expected.to respond_to(:electric_sites) }
    it { is_expected.to respond_to(:electricity) }
    it { is_expected.to respond_to(:outhouse) }
    it { is_expected.to respond_to(:showers) }
    it { is_expected.to respond_to(:dump) }
    it { is_expected.to respond_to(:on_lake) }
    it { is_expected.to respond_to(:on_river) }
    it { is_expected.to respond_to(:beach) }
    it { is_expected.to respond_to(:fifty_amp) }
    it { is_expected.to respond_to(:thirty_amp) }
    it { is_expected.to respond_to(:twenty_amp) }
    it { is_expected.to respond_to(:wifi) }
    it { is_expected.to respond_to(:laundry) }
    it { is_expected.to respond_to(:pull_thrus) }

    it { is_expected.to respond_to(:to_json_v1) }
    it { is_expected.to respond_to(:to_geojson) }
    it { is_expected.to respond_to(:name_search) }
    it { is_expected.to respond_to(:map_search) }
    it { is_expected.to respond_to(:add_city_and_address) }
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

  it "when total_sites is not integer" do
    @campsite.total_sites = "One hundred"
    @campsite.save
    expect(@campsite.total_sites).to eq 0 
    #it { is_expected.not_to be_valid }
  end

  it "when outhouse is not boolean" do
    @campsite.outhouse = "Slitheren"
    @campsite.save
    expect(@campsite.outhouse).to eq false
  end

  it "when showers is not boolean" do
    @campsite.showers = "Ravenclaw"
    @campsite.save
    expect(@campsite.outhouse).to eq true 
  end

  it "when dump is not boolean" do
    @campsite.dump = "Griffendor"
    @campsite.save
    expect(@campsite.dump).to eq false
  end

  it "when likely_toilets is not boolean" do
  end

  it "when no_toilets is not boolean" do
  end

  # API V1 METHODS ==============================================================================================
  describe "to_json_v1 method" do
    before { @campsite.save }
    let(:json) { JSON.parse(@campsite.to_json_v1.to_json) }

    it "should return name for each campsite as :name" do
      expect(json["name"]).to eq @campsite.name
    end
    it "should return :owner" do
      expect(json["owner"]).to eq @campsite.owner
    end
    it "should return :state_abbrev" do
      expect(json["state"]).to eq @campsite.state_abbrev
    end
    it "should return phone number as :phone" do
      expect(json["phone"]).to eq @campsite.phone
    end
    it "should return latitude as :latitude" do
      expect(json["latitude"]).to eq @campsite.latitude
    end
    it "should return longitude as :longitude" do
      expect(json["longitude"]).to eq @campsite.longitude
    end
    it "should return elevation as :elevation" do
      expect(json["elevation"]).to eq @campsite.elevation
    end
    it "should return :showers, :electricity, :dump, :water, and toilet info" do
      expect(json["showers"]).to eq @campsite.showers 
      expect(json["electricity"]).to eq @campsite.electricity
      expect(json["dump"]).to eq @campsite.dump
      expect(json["water"]).to eq @campsite.water
      expect(json["likely_toilets"]).to eq @campsite.likely_toilets
      expect(json["no_toilets"]).to eq @campsite.no_toilets
    end
    it "should return :rustic, :rv, :backcountry, :horse" do
      expect(json["owner"]).to eq @campsite.owner
    end
  end

  # METHODS FOR SEARCH/MAPPING LOGIC ============================================================================================
  describe "to_geojson" do 
    it "should respond with campsite properties" do
      json = JSON.parse(@campsite.to_geojson.to_json)
      expect(json["properties"]["title"]).to eq @campsite.name
    end
    it "should respond with campsite longitude" do
      json = JSON.parse(@campsite.to_geojson.to_json)
      expect(json["geometry"]["coordinates"][0]).to eq @campsite.longitude
    end
  end

  describe "map_search method" do
    it "should respond with nearby campsites" do
      results = Campsite.map_search("#{@campsite.latitude}, #{@campsite.longitude}", 10, 30)
      expect(results.first).to be_include @campsite
    end
  end

  describe "name_search method" do
    it "should respond with campsite when the name matches" do
      expect(Campsite.name_search(@campsite.name).first).to eq @campsite
    end
    it "should not respond with campsite when the name does not match" do
      expect(Campsite.name_search("banana")).to be_blank
    end
  end

  # METHODS FOR GENERATING DATA ========================================================================================
  describe "analyze_toilets method" do
    describe "should run before_save" do
    end
    describe "should set likely_toilets to true under appropriate conditions" do
    end
    describe "should set no_toilets to true under appropriate conditions" do
    end
  end

  describe "add_city_and_address" do
    it "should add and save city and address names" do
      @campsite.add_city_and_address
      expect(@campsite.city_name).not_to be_nil
      expect(@campsite.address).not_to be_nil
    end
  end

end

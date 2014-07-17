require 'rails_helper'

RSpec.describe Api::V1::SearchesController, :type => :controller do
  
  # /api/v1/searches?keywords=foo&distance=bar
  describe "GET #show" do
    let(:campsite) { FactoryGirl.create(:campsite) }
    let(:nearby_campsite) { FactoryGirl.create(:nearby_campsite) }
    before do
      get :show, params: {keywords:"#{campsite.latitude}, #{campsite.longitude}"}
    end
    let(:result_json) { JSON.parse(response.body) }
    
    it "should respond with nearby campsites" do
      expect(result_json[0]["id"]).to eq campsite.id
      expect(result_json[1]["id"]).to eq nearby_campsite.id
    end

    it "should respond with states" do
      expect(result_json[1]["state"]).to eq nearby_campsite.state
    end

    it "should respond with latitude and longitudes" do
      expect(result_json[1]["latitude"]).to eq nearby_campsite.latitude
      expect(result_json[1]["longitude"]).to eq nearby_campsite.longitude
    end

    it "should respond with elevations" do
      expect(result_json[1]["elevation"]).to eq nearby_campsite.elevation
    end

    it "should respond with showers, dump, and outhouses" do
      expect(result_json[1]["showers"]).to eq nearby_campsite.showers
      expect(result_json[1]["dump"]).to eq nearby_campsite.dump
      expect(result_json[1]["outhouse"]).to eq nearby_campsite.outhouse
    end

    it "should respond with success" do
      expect(response).to be_success
    end

  end # End of GET #show
end
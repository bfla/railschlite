require 'rails_helper'

RSpec.describe Api::V1::SearchesController, :type => :controller do
  
  # /api/v1/searches?keywords=foo&distance=bar
  describe "GET #show" do
    context "when user searches area that has nearby campsites with valid API key" do
      let(:campsite) { FactoryGirl.create(:campsite) }
      let(:nearby_campsite) { FactoryGirl.create(:nearby_campsite) }
      
      before do
        # Be careful here.  For some reason, this part of the test is very finicky.  
        # It doesn't want to find the nearby_campsite...
        get :show, {latitude:"#{(campsite.latitude + nearby_campsite.latitude)/2}", longitude:"#{(campsite.longitude + nearby_campsite.longitude)/2}", 
                    api_key:"1af20713-4a94-4c86-b1f4-219fb22e7b1a"}
      end
      let(:result_json) { JSON.parse(response.body) }
      
      it "should respond with nearby campsites" do
        #puts result_json
        puts nearby_campsite.name
        expect(result_json[1]["name"]).to eq campsite.name
        expect(result_json[0]["name"]).to eq nearby_campsite.name
      end

      it "should respond with states" do
        expect(result_json[0]["state"]).to eq nearby_campsite.state
      end

      it "should respond with latitude and longitudes" do
        expect(result_json[0]["latitude"]).to eq nearby_campsite.latitude
        expect(result_json[0]["longitude"]).to eq nearby_campsite.longitude
      end

      it "should respond with elevations" do
        expect(result_json[0]["elevation"]).to eq nearby_campsite.elevation
      end

      it "should respond with showers, dump, and outhouses" do
        expect(result_json[0]["showers"]).to eq nearby_campsite.showers
        expect(result_json[0]["dump"]).to eq nearby_campsite.dump
        expect(result_json[0]["outhouse"]).to eq nearby_campsite.outhouse
      end

      it "should respond with success" do
        expect(response).to be_success
      end
    end #End of context where campsites do exist nearby
  end # End of GET #show

  context "when user searches area that has nearby campsites with invalid API key" do
    let(:campsite) { FactoryGirl.create(:campsite) }
    let(:nearby_campsite) { FactoryGirl.create(:nearby_campsite) }
    before do
      # Be careful here.  For some reason, this part of the test is very finicky.  
      # It doesn't want to find the nearby_campsite...
      get :show, {latitude:"#{(campsite.latitude + nearby_campsite.latitude)/2}", longitude:"#{(campsite.longitude + nearby_campsite.longitude)/2}", 
                  api_key:"i_am_a_clever_hacker"}
    end
    let(:result_json) { JSON.parse(response.body) }

    it "should deny access" do
      expect(response).not_to be_success
    end

    it "should throw 404" do
      expect(response).to have_http_status(401)
    end

  end
end
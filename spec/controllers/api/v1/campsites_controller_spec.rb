require 'rails_helper'

RSpec.describe Api::V1::CampsitesController, :type => :controller do
  
  # /api/campsites/:id
  describe "GET #show" do
    context "when the id matches an existing campsite" do
      let(:campsite) { FactoryGirl.create(:campsite) }
      before { get :show, id:campsite.id, api_key:"1af20713-4a94-4c86-b1f4-219fb22e7b1a" }
      let(:attributes) { JSON.parse(response.body) }
      
      it "should respond with chomp_id" do
        expect(attributes["id"]).to eq campsite.id
      end

      it "should respond with state" do
        expect(attributes["state"]).to eq campsite.state
      end

      it "should respond with latitude and longitude" do
        expect(attributes["latitude"]).to eq campsite.latitude
        expect(attributes["longitude"]).to eq campsite.longitude
      end

      it "should respond with elevation" do
        expect(attributes["elevation"]).to eq campsite.elevation
      end

      it "should respond with showers, dump, and outhouse" do
        expect(attributes["showers"]).to eq campsite.showers
        expect(attributes["dump"]).to eq campsite.dump
        expect(attributes["outhouse"]).to eq campsite.outhouse
      end

      it "should respond with success" do
        expect(response).to be_success
      end
    end # End of context for existing mystery

    context "when id does not match an existing mystery" do
      it "should respond with 404" do
        get :show, id:987
        expect(response).to have_http_status(404)
      end
    end

    context "when API key is invalid" do
      let(:campsite) { FactoryGirl.create(:campsite) }
      before { get :show, id:campsite.id, api_key:"i_am_a_stranger_do_not_talk_to_me" }
      let(:attributes) { JSON.parse(response.body) }

      it "should deny access" do
        expect(response).not_to be_success
      end

      it "should throw 404" do
        expect(response).to have_http_status(401)
      end
    end
  end # End of GET #show
end
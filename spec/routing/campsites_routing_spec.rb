require "rails_helper"

RSpec.describe CampsitesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/campsites").to route_to("campsites#index")
    end

    it "routes to #new" do
      expect(:get => "/campsites/new").to route_to("campsites#new")
    end

    it "routes to #show" do
      expect(:get => "/campsites/1").to route_to("campsites#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/campsites/1/edit").to route_to("campsites#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/campsites").to route_to("campsites#create")
    end

    it "routes to #update" do
      expect(:put => "/campsites/1").to route_to("campsites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/campsites/1").to route_to("campsites#destroy", :id => "1")
    end

  end
end

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

RSpec.describe SearchesController, :type => :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/").to route_to("searches#show")
    end

  end
end

RSpec.describe PagesController, :type => :routing do
  describe "routing" do

    it "GET #support" do
      expect(:get => "/support/").to route_to("pages#support")
    end

    it "GET #mobile_teaser" do
      expect(:get => "/mobile_teaser/").to route_to("pages#mobile_teaser")
    end

    it "GET #terms" do
      expect(:get => "/terms/").to route_to("pages#terms")
    end

    it "GET #privacy" do
      expect(:get => "/privacy/").to route_to("pages#privacy")
    end

    it "GET #takedown" do
      expect(:get => "/takedown/").to route_to("pages#takedown")
    end

  end
end

# API V1 =========================================================================================
RSpec.describe Api::V1::CampsitesController, :type => :routing do
  describe "routing" do
    it "GET with :id" do
      expect(:get => "/api/v1/campsites/1").to route_to("api/v1/campsites#show", id:"1")
    end
  end
end

RSpec.describe Api::V1::SearchesController, :type => :routing do
  describe "routing" do
    it "GET" do
      expect(:get => "/api/v1/searches").to route_to("api/v1/searches#show")
    end
  end
end


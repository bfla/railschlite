require 'rails_helper'

RSpec.describe "Destinations", :type => :request do
  describe "GET /destinations" do
    it "works! (now write some real specs)" do
      get destinations_path
      expect(response.status).to be(200)
    end
  end
end

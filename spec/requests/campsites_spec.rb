require 'rails_helper'

RSpec.describe "Campsites", :type => :request do
  describe "GET /campsites" do
    it "works! (now write some real specs)" do
      get campsites_path
      expect(response.status).to be(200)
    end
  end
end

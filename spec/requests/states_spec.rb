require 'rails_helper'

RSpec.describe "States", :type => :request do
  describe "GET /states" do
    it "works! (now write some real specs)" do
      get states_path
      expect(response.status).to be(200)
    end
  end
end

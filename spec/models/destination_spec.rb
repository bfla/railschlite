require 'rails_helper'

RSpec.describe Destination, :type => :model do

  before { @destination = FactoryGirl.create(:destination) }
  subject { @destination }

  describe "when new Campsite is created with valid inputs" do 
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:state_id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:latitude) }
    it { is_expected.to respond_to(:longitude) }
    it { is_expected.to respond_to(:zoom) }
    it { is_expected.to respond_to(:radius) }
    it { is_expected.to respond_to(:slug) }
    it { is_expected.to respond_to(:highlights) }
    it { is_expected.to respond_to(:things_to_do) }
    it { is_expected.to respond_to(:camping_tips) }
  end

end

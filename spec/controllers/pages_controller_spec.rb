require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  # GET /mobile_teaser
  it "should render mobile_teaser page" do
    get :mobile_teaser
    expect(response).to render_template("mobile_teaser")
    expect(response).to have_http_status(200)
  end

  # GET /support
  it "should render support page" do
    get :support
    expect(response).to render_template("support")
    expect(response).to have_http_status(200)
  end

  # LEGAL PAGES =============================================================
  # GET /terms
  it "should render terms page" do
    get :terms
    expect(response).to render_template("terms")
    expect(response).to have_http_status(200)
  end

  # GET /privacy
  it "should render privacy page" do
    get :privacy
    expect(response).to render_template("privacy")
    expect(response).to have_http_status(200)
  end

  # GET /takedown
  it "should render takedown page" do
    get :takedown
    expect(response).to render_template("takedown")
    expect(response).to have_http_status(200)
  end

end
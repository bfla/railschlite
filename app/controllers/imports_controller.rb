class ImportsController < ApplicationController
  before_action :verify_admin
  
  # POST 
  def create
    Campsite.import(params[:file])
    redirect_to root_url, notice:"imported!"
  end


end
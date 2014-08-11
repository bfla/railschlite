class ImportsController < ApplicationController
  before_action :verify_admin
  
  def campsite_import
    Campsite.import(params[:file])
    redirect_to root_url, notice:"imported!"
  end

  def special_one_time_import
    Campsite.special_one_time_import(params[:file])
    redirect_to root_url, notice:"imported!"
  end

  def destination_import
    Destination.import(params[:file])
    redirect_to root_url, notice:"imported!"
  end

  def city_import
    City.import(params[:file])
    redirect_to root_url, notice:"imported!"
  end

  def state_import
    State.import(params[:file])
    redirect_to root_url, notice:"imported!"
  end

end
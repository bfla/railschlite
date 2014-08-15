class PagesController < ApplicationController

  def home
    @destinations = Destination.featured.first(4)
    @cities = City.featured.first(4)
    @states = State.featured.first(4)
    @campsites = Campsite.featured.first(4)
  end
  
  def support
  end

  def mobile_teaser
  end

  # LEGAL PAGES ==========================
  def terms
  end

  def privacy
  end

  def takedown
  end


  # include these for Google
  def smallbiz
  end

  def bloggers
  end

  def reasons
  end

  def sitemap
    @domain = "http://#{request.host_with_port}"
    @states = State.all()
  end

  def sitemap_for_static_pages
    @static_sites = [
      '',
      '/terms',
      '/takedown',
      '/privacy',
      '/support',
      #'/bloggers',
      #'/reasons',
      #'/users/sign_up',
      #'/users/sign_in',
      '/states',
      '/campsites',
      '/cities',
      '/destinations',
    ]
    @domain = "http://#{request.host_with_port}"
  end

  def sitemap_for_state
    @domain = "http://#{request.host_with_port}"
    @state = State.includes(:campsites, :cities, :destinations).find(params[:id])
  end

end
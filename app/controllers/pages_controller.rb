class PagesController < ApplicationController

  def home
    @destinations = Destination.first(4)
    @cities = City.first(4)
    @states = State.first(4)
    @campsites = Campsite.first(4)
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

    @campsites = Campsite.all()
    @states = State.all()
    @cities = City.all()
    @destinations = Destination.all()

    respond_to do |format|
      format.xml
    end
  end

end
xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  
  @static_sites.each do |p|
    xml.url {
      xml.loc("#{@domain}#{p}")
      xml.changefreq("monthly")
      xml.priority(0.7)
    }
  end

  @campsites.each do |p|
    xml.url {
      xml.loc("#{@domain}/campsites/#{p.slug}")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("weekly")
      xml.priority(0.8)
    }
  end

  @states.each do |p|
    xml.url {
      xml.loc("#{@domain}/states/#{p.slug}")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("weekly")
      xml.priority(0.9)
    }
    xml.url { #cities in...
      xml.loc("#{@domain}/states/#{p.slug}/cities")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("monthly")
      xml.priority(0.7)
    }
    xml.url { #destinations in...
      xml.loc("#{@domain}/states/#{p.slug}/camping-destinations")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("monthly")
      xml.priority(0.7)
    }
    xml.url { #all campsites in...
      xml.loc("#{@domain}/states/#{p.slug}/campgrounds")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("monthly")
      xml.priority(0.7)
    }
  end

  @cities.each do |p|
    xml.url {
      xml.loc("#{@domain}/cities/#{p.slug}")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("weekly")
      xml.priority(0.9) 
    }
    xml.url {
      xml.loc("#{@domain}/cities/#{p.slug}/campgrounds")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("monthly")
      xml.priority(0.8) 
    }
  end

  @destinations.each do |p|
    xml.url {
      xml.loc("#{@domain}/destinations/#{p.slug}")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("weekly")
      xml.priority(1.0)
    }
    xml.url {
      xml.loc("#{@domain}/destinations/#{p.slug}/campgrounds")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("monthly")
      xml.priority(0.8) 
    }
  end

end
xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url { #state show
    xml.loc("#{@domain}/states/#{@state.slug}")
    xml.lastmod(@state.updated_at.strftime("%F"))
    xml.changefreq("monthly")
    xml.priority(0.8)
  }
  xml.url { #cities index...
    xml.loc("#{@domain}/states/#{@state.slug}/cities")
    xml.lastmod(@state.updated_at.strftime("%F"))
    xml.changefreq("monthly")
    xml.priority(0.7)
  }
  xml.url { #destinations index...
    xml.loc("#{@domain}/states/#{@state.slug}/camping-destinations")
    xml.lastmod(@state.updated_at.strftime("%F"))
    xml.changefreq("monthly")
    xml.priority(0.7)
  }
  xml.url { #campsites index...
    xml.loc("#{@domain}/states/#{@state.slug}/campgrounds")
    xml.lastmod(@state.updated_at.strftime("%F"))
    xml.changefreq("monthly")
    xml.priority(0.7)
  }

  @state.campsites.each do |p|
    xml.url { #campsite pages...
      xml.loc("#{@domain}/campsites/#{p.slug}")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("weekly")
      xml.priority(0.9)
    }
  end
  @state.cities.each do |p|
    xml.url {
      xml.loc("#{@domain}/cities/#{p.slug}")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("weekly")
      xml.priority(0.8)
    }
  end
  @state.destinations.each do |p|
    xml.url {
      xml.loc("#{@domain}/destinations/#{p.slug}")
      xml.lastmod(p.updated_at.strftime("%F"))
      xml.changefreq("weekly")
      xml.priority(0.8)
    }
  end
end
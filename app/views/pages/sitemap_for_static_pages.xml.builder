xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do

  @static_sites.each do |p|
    xml.url {
      xml.loc("#{@domain}#{p}")
      xml.changefreq("monthly")
      xml.priority(0.7)
    }
  end
end
xml.instruct! :xml, :version=>'1.0', :encoding=> 'UTF-8'
xml.tag! 'sitemapindex', 'xmlns'=>"http://www.sitemaps.org/schemas/sitemap/0.9" do
  
  xml.sitemap { #static page sitemap
    xml.loc("#{@domain}/sitemap_for_static_pages.xml")
    xml.lastmod('2014-08-15')
  }

  @states.each do |p| #sitemap for all content in each state
    xml.sitemap {
      xml.loc("#{@domain}/sitemap_for_state/#{p.id}.xml")
      xml.lastmod(p.updated_at.strftime("%F"))
    }
  end
end

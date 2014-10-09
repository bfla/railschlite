module CampsitesHelper

  def campsite_header_url(campsite)
    asset_path "/images/backgrounds/camping-header.jpg"
  end

  def tribe_name(campsite)
    if campsite.horse?
      "Horse Friendly"
    elsif campsite.backcountry?
      "Backcountry"
    elsif campsite.rv?
      "RV Friendly"
    else 
      "Rustic"
    end
  end

  def tribe_icon(campsite)
    if campsite.horse?
      image_path 'icons/Horse120.png'
    elsif campsite.backcountry?
      image_path 'icons/Backcountry120.png'
    elsif campsite.rv?
      image_path 'icons/RV120.png'
    else 
      image_path 'icons/Rustic120.png'
    end
  end

  def toilets_image(campsite)
    if campsite.no_toilets
      image_path 'icons/NoOuthouse100.png'
    elsif campsite.likely_toilets
      image_path 'icons/Outhouse100.png'
    else
      image_path 'icons/MaybeOuthouse100.png'
    end
  end

  def showers_image(campsite)
    campsite.showers ? image_path('icons/Showers100.png') : image_path('icons/NoShowers100.png')
  end

  def electricity_image(campsite)
    campsite.electricity ? image_path('icons/Electric100.png') : image_path('icons/NoElectric100.png')
  end

  def dump_image(campsite)
    campsite.dump ? image_path('icons/Dump100.png') : image_path('icons/NoDump100.png')
  end

  def water_image(campsite)
    campsite.water ? image_path('icons/Water100.png') : image_path('icons/NoWater100.png')
  end

end

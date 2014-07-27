module CampsitesHelper
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

  def tribe_image(campsite)
    if campsite.horse?
      "horse"
    elsif campsite.backcountry?
      "backcountry"
    elsif campsite.rv?
      "rv"
    else 
      "rustic"
    end
  end
end

module ApplicationHelper
  def authorized?
    if admin_signed_in? && current_admin.approved?
      true
    else 
      false
    end
  end

  def app_store_url
    "https://itunes.apple.com/us/app/camphero-lite-usa-campground/id903533893"
  end
end

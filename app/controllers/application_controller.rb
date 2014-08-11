class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def verify_admin
    unless admin_signed_in? && current_admin.approved?
      render json: {error:"401 Unauthorized: This is CampHero Lite's secret fortress.  Only CampHero's sidekicks can unlock its mysteries."}.to_json, status:401
    end
  end
end

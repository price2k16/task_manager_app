class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Add authentication check to ensure the user is signed in
  before_action :authenticate_user!

  # Redirect to login page after sign out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirects the user to the login page after logging out
  end
end



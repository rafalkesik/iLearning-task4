class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :authorize_user!, if: :user_signed_in?, unless: :devise_controller?

  private

    def authorize_user!
      return if current_user.active?

      sign_out current_user
      flash[:alert] = "Your account is blocked"
      redirect_to new_user_session_path
    end
end

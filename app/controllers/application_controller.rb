class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :cofigure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.js { render js: "", status: :not_found } 
    end
  end

  protected

  def cofigure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end

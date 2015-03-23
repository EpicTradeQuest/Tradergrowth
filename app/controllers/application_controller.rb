class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_filter :set_var
  protect_from_forgery with: :exception
  helper_method :unit
  helper_method :trial_expired?

  # Define the unit the user wants to use to record their trades.
  def unit
    unitchoice = current_user.trade_unit
    if unitchoice == 1
      @unit = "pips"
    elsif unitchoice == 2
      @unit = "points"
    elsif unitchoice == 3
      @unit = "dollars"
    elsif unitchoice == 4
      @unit = "percent"
    elsif unitchoice == 5
      @unit = "R"
    else
      @unit = "undefined"
    end
  end

  # Set trial length.
  def remaining_days
   ((current_user.created_at + 30.days).to_date - Date.today).round
  end

  # If trial length is expired, this triggers the change of form on the index.html.haml on the dashboard.
  def trial_expired?
    remaining_days <= 0
  end

  def set_var
    if current_user
      @user_id = current_user.id
      @created_at = current_user.created_at.to_date
      @email = current_user.email
    end
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [ :email, :password, :password_confirmation, :trade_unit]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end

end
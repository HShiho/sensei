class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user



private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:nickname])
  end

  def set_user
    @current_user = current_user
  end

  def achivement_hash
    [{enum: 'excellence', icon: 'laugh-squint', checked: true}, {enum: 'good', icon: 'smile', checked: false}, {enum: 'almost', icon: 'rolling-eyes', checked: false}]
  end

end

class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||=Ability.new(current_admin)
  end
end

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

  def after_sign_in_path_for(resource)
    case resource.role
    when 0
      my_tournaments_path # Redireciona organizadores para seus torneios
    when 1
      tournaments_path # Redireciona participantes para a lista de torneios
    else
      root_path # Redireciona para a home se a role for inválida
    end
  end
end
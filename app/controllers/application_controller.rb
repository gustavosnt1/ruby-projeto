class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def after_sign_in_path_for(resource)
    # Verifica a role do usuário e redireciona conforme necessário
    if resource.role == 0
      # Redireciona para a página de criação de torneios
      new_tournament_path
    elsif resource.role == 1
      # Redireciona para a página de exibição de torneios (exemplo: o primeiro torneio ou um torneio específico)
      tournaments_path
    else
      root_path # Caso o usuário não tenha uma role definida, redireciona para a página inicial
    end
  end
end
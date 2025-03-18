class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def create
    tournament = Tournament.find(params[:tournament_id])
    # Verifica se o usuário já está inscrito antes de criar uma nova inscrição
    unless tournament.registrations.exists?(user_id: current_user.id)
      tournament.registrations.create(user: current_user)
      redirect_to tournament, notice: "Inscrição realizada com sucesso!"
    else
      redirect_to tournament, alert: "Você já está inscrito neste torneio."
    end
  end

  def destroy
    registration = Registration.find(params[:id])
    registration.destroy
    redirect_to registration.tournament, notice: "Inscrição cancelada."
  end
end
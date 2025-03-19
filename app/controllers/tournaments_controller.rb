class TournamentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_tournament, only: [:show, :edit, :update, :registrations]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    authorize! :read, Tournament
    @tournaments = Tournament.all
  end

  def show
    authorize! :read, @tournament
    @tournament = Tournament.find(params[:id])
  end

  def new
    authorize! :create, Tournament
    @tournament = Tournament.new
  end

  def create
    @tournament = current_user.tournaments.build(tournament_params)
    authorize! :create, @tournament

    if @tournament.save
      redirect_to my_tournaments_path, notice: "Torneio criado com sucesso!"
    else
      render :new
    end
  end

  def update
    authorize! :update, @tournament 
    
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      redirect_to my_tournaments_path, notice: "Torneio atualizado com sucesso!"
    else
      render :edit
    end

  end

  def authorize_user!
    if current_user.nil?
      redirect_to new_user_session_path, alert: "Você precisa estar logado para ver seus torneios."
      return
    end

    if current_user.role == 1
      redirect_to tournaments_path, alert: 'Você não tem permissão para editar este torneio.'
    end
  end

  def registrations
    authorize! :read, @tournament

    @tournament = Tournament.find(params[:tournament_id])
    @registrations = @tournament.registrations
  end

  def my_tournaments
    if current_user.nil?
      redirect_to new_user_session_path, alert: "Você precisa estar logado para ver seus torneios."
      return
    end

    authorize! :read, Tournament 

    if current_user.role == 0
      @tournaments = current_user.tournaments
    else
      redirect_to tournaments_path, alert: "Você não tem permissão para acessar essa página."
    end
  end

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id] || params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Torneio não encontrado."
    redirect_to my_tournaments_path
  end

  private
  def tournament_params
    params.require(:tournament).permit(:name, :game)
  end
end
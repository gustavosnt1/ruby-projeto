class TournamentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_tournament, only: [:show, :edit, :update, :registrations]

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = current_user.tournaments.build(tournament_params)
    if @tournament.save
      redirect_to @tournament, notice: "Torneio criado com sucesso!"
    else
      render :new
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      redirect_to my_tournaments_path, notice: "Torneio atualizado com sucesso!"
    else
      render :edit
    end
  end

  def registrations
    @tournament = Tournament.find(params[:tournament_id])
    @registrations = @tournament.registrations
  end

  def my_tournaments
    @tournaments = current_user.tournaments
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
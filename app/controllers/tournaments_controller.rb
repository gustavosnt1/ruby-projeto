class TournamentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
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

  private
  def tournament_params
    params.require(:tournament).permit(:name, :game)
  end
end
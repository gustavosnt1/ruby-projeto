Rails.application.routes.draw do
  devise_for :users

  # Torneios
  resources :tournaments, only: [:index, :new, :create, :show] do
    # Inscrições dentro de torneios
    resources :registrations, only: [:create, :destroy]
  end

  # Remover inscrição (fora da criação de torneio)
  resources :registrations, only: [:destroy]

  # Página inicial
  get "home/index"
  
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root to: "home#index"
end

class HomeController < ApplicationController
  def index
  end
end
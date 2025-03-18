class User < ApplicationRecord
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
     
       has_many :tournaments, foreign_key: "organizer_id"
       has_many :registrations
       has_many :participated_tournaments, through: :registrations, source: :tournament
end
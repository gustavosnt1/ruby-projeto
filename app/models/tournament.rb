class Tournament < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  has_many :registrations
  has_many :participants, through: :registrations, source: :user
end
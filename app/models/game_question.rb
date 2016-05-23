class GameQuestion < ApplicationRecord
  belongs_to :game
  belongs_to :question
  has_many :user_answers

  enum status: [:pending, :active, :finished]
end

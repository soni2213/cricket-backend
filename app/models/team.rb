class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end

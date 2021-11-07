class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end

# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_teams_on_name  (name) UNIQUE
#

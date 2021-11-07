# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint
#
# Indexes
#
#  index_players_on_name     (name) UNIQUE
#  index_players_on_team_id  (team_id)
#
require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:team) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end

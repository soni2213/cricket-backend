# == Schema Information
#
# Table name: matches
#
#  id             :bigint           not null, primary key
#  status         :string           default("planned")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  team1_id       :integer          not null
#  team2_id       :integer          not null
#  toss_winner_id :integer
#  winner_id      :integer
#
# Indexes
#
#  index_matches_on_team1_id   (team1_id)
#  index_matches_on_team2_id   (team2_id)
#  index_matches_on_winner_id  (winner_id)
#
require 'rails_helper'

RSpec.describe Match, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:team1) }
    it { is_expected.to belong_to(:team2) }
    it { is_expected.to belong_to(:winner).optional }
    it { is_expected.to belong_to(:toss_winner).optional }

    it { is_expected.to have_many(:balls) }
    it { is_expected.to have_many(:wickets) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
  end
end

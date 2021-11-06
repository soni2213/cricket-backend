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

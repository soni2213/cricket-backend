require 'rails_helper'

RSpec.describe Ball, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:match) }
    it { is_expected.to belong_to(:batsman) }
    it { is_expected.to belong_to(:bowler) }
    it { is_expected.to have_one(:wicket) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:score) }
  end
end

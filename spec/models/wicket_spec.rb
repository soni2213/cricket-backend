require 'rails_helper'

RSpec.describe Wicket, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:ball) }
    it { is_expected.to belong_to(:batsman) }
    it { is_expected.to belong_to(:bowler) }
    it { is_expected.to belong_to(:fielder).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:wicket_type) }
  end
end

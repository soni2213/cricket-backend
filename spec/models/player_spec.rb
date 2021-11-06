require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:team) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end

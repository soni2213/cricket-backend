# == Schema Information
#
# Table name: wickets
#
#  id          :bigint           not null, primary key
#  wicket_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ball_id     :integer          not null
#  batsman_id  :integer          not null
#  bowler_id   :integer          not null
#  fielder_id  :integer
#
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

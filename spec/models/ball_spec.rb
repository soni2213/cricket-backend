# frozen_string_literal: true

# == Schema Information
#
# Table name: balls
#
#  id         :bigint           not null, primary key
#  extra      :boolean          default(FALSE), not null
#  score      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  batsman_id :integer          not null
#  bowler_id  :integer          not null
#  match_id   :integer          not null
#
# Indexes
#
#  index_balls_on_match_id  (match_id)
#
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

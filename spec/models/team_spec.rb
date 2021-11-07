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
require 'rails_helper'

RSpec.describe Team, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:players) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end

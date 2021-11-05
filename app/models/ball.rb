class Ball < ApplicationRecord

  belongs_to :batsman, class_name: 'Player', foreign_key: 'batsman_id'
  belongs_to :bowler, class_name: 'Player', foreign_key: 'bowler_id'
  belongs_to :match

  has_one :wicket

  validates :score, presence: true
  attr_accessor :wicket_type, :fielder_id

  before_create :build_review

  private

  def build_review
    return unless wicket_type.present?

    self.wicket = Wicket.new(bowler_id: bowler_id,
                               batsman_id: batsman_id,
                               wicket_type: wicket_type,
                               fielder_id: fielder_id)
  end
end

class Wicket < ApplicationRecord

  belongs_to :batsman, class_name: 'Player', foreign_key: 'batsman_id'
  belongs_to :bowler, class_name: 'Player', foreign_key: 'bowler_id'
  belongs_to :ball

  validates :wicket_type, presence: true
end

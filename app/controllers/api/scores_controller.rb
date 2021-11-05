# frozen_string_literal: true

module Api
  class ScoresController < Api::BaseController
    skip_before_action :authenticate_user!, only: %w[retrieve_score]

    def record_score
      Ball.create!(score_params)
    end

    def record_toss
      Match.find(params[:match_id])
           .update!(toss_params)
    end

    def retrieve_score
      if Match.find(fetch_score_params).winner
        { score: total_score, wickets: total_wickets}
      else
      end
    end

    def match_winner
      Match.find(params[:match_id]).update!(winner_params)
    end

    private

    def score_params
      params.permit(:bowler_id,
                    :batsman_id,
                    :match_id,
                    :wicket_type,
                    :fielder_id,
                    :score,
                    :extra)
    end

    def toss_params
      params.permit(:toss_winner_id)
    end

    def fetch_score_params
      params.permit(:match_id)
    end

    def winner_params
      params.permit(:winner_id)
    end

    def player_ids
      team = Team.find(params[:team_id])
      team.players.pluck(:id)
    end

    def total_score
      Ball.where(batsman_id: player_ids).sum(:score)
    end

    def total_wickets
      Wicket.where(batsman_id: player_ids).count
    end
  end
end

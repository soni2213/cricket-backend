class Match::Summary
  attr_reader :match,
              :team1,
              :team2

  def initialize(match)
    @match = match
    @team1 = match.toss_winner
    @team2 = match.toss_loser
  end

  def print
    if match.in_progress?
      print_brief
    else
      print_summary
    end
  end

  private

  def print_brief
    brief = {}
    brief[team1.name] = team_brief(team1)
    brief[team2.name] = team_brief(team2)
    brief
  end

  def print_summary
    summary = {}
    summary[:brief] = print_brief
    summary[team1.name] = team_summary(team1)
    summary[team2.name] = team_summary(team2)
    summary
  end

  def team_brief(team)
    score = match.balls.where(batsman_id: team.player_ids).sum(:score)
    wickets = match.wickets.where(batsman_id: team.player_ids).count
    "#{score} / #{wickets}"
  end

  def team_summary(team)
    summary = {}
    team.players.each do |player|
      summary[player.name] = player_summary(player)
    end
    summary # .select { |k,v| v.present? }
  end

  def player_summary(player)
    balls_played = match.balls.where(batsman_id: player.id, extra: false).count
    return {} unless balls_played.positive?

    wicket_taker = match.wickets.find_by(batsman_id: player.id)&.bowler_name

    summary = {}
    summary[:runs] = match.balls.where(batsman_id: player.id).sum(:score)
    summary[:balls_played] = balls_played
    summary[:wicket_taker] = wicket_taker if wicket_taker.present?
    summary
  end

  def overs_played(team)
    match.balls.where(extra: false, player_id: team.player_ids).count / 6
  end
end

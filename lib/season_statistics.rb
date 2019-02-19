require './lib/season_record_stats'
require './lib/league_offense_stats'

module SeasonStatistics
  include SeasonRecordStats
  
  def biggest_bust(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    preseason_win_loss_records = preseason_records(games_by_season)
    regular_season_win_loss_records = regular_season_records(games_by_season)
    preseason_win_loss = season_record_percentages(preseason_win_loss_records)
    regular_season_win_loss = season_record_percentages(regular_season_win_loss_records)
    
    regular_season_win_loss.each do |key, _|
      if !preseason_win_loss.key?(key)
        preseason_win_loss[key] = 0
      end
    end

    biggest_bust = regular_season_win_loss.keys.min_by do |key|
      regular_season_win_loss[key] - preseason_win_loss[key]
    end

    @league.teams.find do |team|
      biggest_bust == team.team_id
    end.team_name
  end

  def biggest_surprise(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    preseason_win_loss_records = preseason_records(games_by_season)
    regular_season_win_loss_records = regular_season_records(games_by_season)
    preseason_win_loss = season_record_percentages(preseason_win_loss_records)
    regular_season_win_loss = season_record_percentages(regular_season_win_loss_records)

    regular_season_win_loss.keys.each do |key|
      if !preseason_win_loss.key?(key)
        preseason_win_loss[key] = 0
      end
    end

    biggest_surprise_id = regular_season_win_loss.keys.max_by do |key|
      regular_season_win_loss[key] - preseason_win_loss[key]
    end

    @league.teams.find do |team|
      biggest_surprise_id == team.team_id
    end.team_name

  end

  def winningest_coach(season_id)
    season_games = seasons_games_by_team_id(season_id)
    season_games_by_coach = season_games.group_by {|game| game.head_coach}
    season_games_by_coach.each do |coach, games|
      season_games_by_coach[coach] = games.map { |game| game.won == "FALSE" ? 0 : 1 }
    end
    coach_win_loss = season_record_percentages(season_games_by_coach)
    coach_win_loss.keys.max_by {|coach| coach_win_loss[coach]}
  end

  def worst_coach(season_id)
    season_games = seasons_games_by_team_id(season_id)
    season_games_by_coach = season_games.group_by {|game| game.head_coach}
    season_games_by_coach.each do |coach, games|
      season_games_by_coach[coach] = games.map { |game| game.won == "FALSE" ? 0 : 1 }
    end
    coach_win_loss = season_record_percentages(season_games_by_coach)
    coach_win_loss.keys.min_by {|coach| coach_win_loss[coach]}
  end

  def most_accurate_team(season_id)
    shot_goal_ratio_by_team_id = shot_goal_records(season_id)
    most_accurate_team_id = shot_goal_ratio_by_team_id.keys.max_by do |team_id|
      shot_goal_ratio_by_team_id[team_id]
    end
    @league.teams.find {|team| team.team_id == most_accurate_team_id}.team_name
  end

  def least_accurate_team(season_id)
    shot_goal_ratio_by_team_id = shot_goal_records(season_id)
    most_accurate_team_id = shot_goal_ratio_by_team_id.keys.min_by do |team_id|
      shot_goal_ratio_by_team_id[team_id]
    end
    @league.teams.find {|team| team.team_id == most_accurate_team_id}.team_name
  end

  def most_hits(season_id)
    total_hits_by_team = hits_records(season_id)
    most_brutal_id = total_hits_by_team.keys.max_by do |team_id|
      total_hits_by_team[team_id]
    end
    @league.teams.find {|team| team.team_id == most_brutal_id}.team_name
  end

  def least_hits(season_id)
    total_hits_by_team = hits_records(season_id)
    softest_id = total_hits_by_team.keys.min_by do |team_id|
      total_hits_by_team[team_id]
    end
    @league.teams.find {|team| team.team_id == softest_id}.team_name
  end

  def power_play_goal_percentage(season_id)
    team_games_in_season = seasons_games_by_team_id(season_id)
    total_power_play_goals = team_games_in_season.inject(0) do |sum, game| 
      sum += game.power_play_goals
    end
    total_goals = team_games_in_season.inject(0) {|sum, game| sum += game.goals}
    (total_power_play_goals / total_goals.to_f).round(2)
  end
end

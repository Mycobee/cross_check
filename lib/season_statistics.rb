require './lib/season_record_stats'

module SeasonStatistics
  include SeasonRecordStats

  def biggest_bust(season_id)
    games_by_season = @league.games.select { |game| game.season == season_id}
    preseason_win_loss  = preseason_records(games_by_season)
    regular_season_win_loss = regular_season_records(games_by_season)
    regular_season_win_loss.each do |key, _|
      if !preseason_win_loss.key?(key)
        preseason_win_loss[key] = 0
      end
    end

    biggest_bust = regular_season_win_loss.keys.min_by do |key|
      (regular_season_win_loss[key] - preseason_win_loss[key]).abs
    end
    @league.teams.find do |team|
      biggest_bust == team.team_id
    end.team_name
  end

  def biggest_surprise(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    regular_season_win_loss = regular_season_records(games_by_season)
    preseason_win_loss = preseason_records(games_by_season)
    regular_season_win_loss.each do |team_id, _|
      if !preseason_win_loss.key?(team_id)
        preseason_win_loss[team_id] = 0
      end
    end
    biggest_surprise_id = regular_season_win_loss.keys.max_by do |key|
      (regular_season_win_loss[key] - preseason_win_loss[key]).abs
    end

    @league.teams.find do |team|
      biggest_surprise_id == team.team_id
    end.team_name
  end

  def winningest_coach(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    regular_season_win_percentages = regular_season_records(games_by_season) 
    winningest_team = regular_season_win_percentages.keys.max_by do |team_id|
      regular_season_win_percentages[team_id]
    end
    @league.team_games.find {|game| game.team_id == winningest_team}.head_coach
  end

  def worst_coach(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    regular_season_win_percentages = regular_season_records(games_by_season) 
    worst_team = regular_season_win_percentages.keys.min_by do |team_id|
      regular_season_win_percentages[team_id]
    end
    @league.team_games.find {|game| game.team_id == worst_team}.head_coach
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

  def power_goal_percentage(season_id)
  end
end

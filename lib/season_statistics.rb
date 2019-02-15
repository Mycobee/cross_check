require './lib/season_record_stats'
require './lib/league_offense_stats'

module SeasonStatistics
  include SeasonRecordStats
  include LeagueOffenseStats
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
      (regular_season_win_loss[key] - preseason_win_loss[key]).abs
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
      (regular_season_win_loss[key] - preseason_win_loss[key]).abs
    end

    @league.teams.find do |team|
      biggest_surprise_id == team.team_id
    end.team_name

  end

  def winningest_coach(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}

    total_win_loss = total_season_win_loss(games_by_season)

    team_win_percentage = season_record_percentages(total_win_loss)
    winningest_team_id = team_win_percentage.keys.max_by {|team_id| team_win_percentage[team_id]}

    winningest_team = @league.team_games.find do |team|
      team.team_id == winningest_team_id
    end

    winningest_team.head_coach

  end

  def worst_coach(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}

    total_win_loss = total_season_win_loss(games_by_season)

    team_win_percentage = season_record_percentages(total_win_loss)
    losingest_team_id = team_win_percentage.keys.min_by {|team_id| team_win_percentage[team_id]}

    losingest_team = @league.team_games.find do |team|
      team.team_id == losingest_team_id
    end
    losingest_team.head_coach

  end

  def most_accurate_team(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    game_groups = @league.team_games.group_by {|game| game.game_id}
    x = games_by_season.inject([]) do |arr, game|

      matching_games = game_groups[game.game_id]

      arr.concat(game_groups[game.game_id]) if matching_games
      arr
    end
    y = x.group_by {|game| game.team_id}
    y.keys.map {|team_game|
      
      require 'pry'; binding.pry}




  end

end

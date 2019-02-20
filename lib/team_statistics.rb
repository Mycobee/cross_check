require_relative 'team_statistics_helper'
module TeamStatistics
  include TeamStatisticsHelper

  def team_info(team_id)
    team = find_team(team_id)
    team_info = team.instance_variables.map do |ivar|
      ivar.to_s.delete("@")
    end
    team_info.inject({}) do |hash, key|
      hash[key] = team.instance_variable_get("@#{key}")
      hash
    end
  end

  def best_season(team_id)
    season_hash = all_games_played_group_by_season(team_id)
    season_hash.each do |season, games|
      home_away_win_loss_array = games.map do |game|
        conditional_setting_of_win_loss(game, team_id, "home", "away")
      end
      home_away_win_loss_array = home_away_win_loss_array.select {|score| score}
      season_hash[season] = home_away_win_loss_array
    end
    season_result = determine_win_or_loss_percentage_per_season(season_hash)
    determine_best_win_or_loss_percentage(season_result)
  end

  def worst_season(team_id)
    season_hash = all_games_played_group_by_season(team_id)
    season_hash.each do |season, games|
      home_away_win_loss_array = games.map do |game|
        conditional_setting_of_win_loss(game, team_id, "away", "home")
      end
      home_away_win_loss_array = home_away_win_loss_array.select {|score| score}
      season_hash[season] = home_away_win_loss_array
    end
    season_result = determine_win_or_loss_percentage_per_season(season_hash)
    determine_best_win_or_loss_percentage(season_result)
  end


  def average_win_percentage(team_id)
    team_wins = winning_games(team_id)
    total_games = all_games_played(team_id)
    avg_win_percentage = (team_wins.count.to_f / total_games.count)
    avg_win_percentage = avg_win_percentage.round(2)
  end

  def most_goals_scored(team_id)
    highest_home_game = home_or_away_games(team_id, "home_team_id").max_by do |game|
      game.home_goals
    end
    highest_away_game = home_or_away_games(team_id, "away_team_id").max_by do |game|
      game.away_goals
    end
    if highest_home_game.home_goals > highest_away_game.away_goals
      highest_home_game.home_goals
    else highest_away_game.away_goals
    end
  end

  def fewest_goals_scored(team_id)
    lowest_home_game = home_or_away_games(team_id, "home_team_id").min_by do |game|
      game.home_goals
    end
    lowest_away_game = home_or_away_games(team_id, "away_team_id").min_by do |game|
      game.away_goals
    end
    if lowest_home_game.home_goals < lowest_away_game.away_goals
      lowest_home_game.home_goals
    else lowest_away_game.away_goals
    end
  end

  def favorite_opponent(team_id)
    home_game_hash = home_or_away_games_group_by_category(team_id, "home_team_id", "away_team_id")
    away_game_hash = home_or_away_games_group_by_category(team_id, "away_team_id", "home_team_id")
    setting_win_loss_as_1_or_0(home_game_hash, "home")
    setting_win_loss_as_1_or_0(away_game_hash, "away")
    home_away_win_loss = combine_home_away_win_loss_results(home_game_hash, away_game_hash)
    team_result = determine_win_or_loss_percentage_per_season(home_away_win_loss)
    team_percentage_pair = determine_best_win_or_loss_percentage(team_result)
    team_id_to_team_name(team_percentage_pair)
  end

  def rival(team_id)
    home_game_hash = home_or_away_games_group_by_category(team_id, "home_team_id", "away_team_id")
    away_game_hash = home_or_away_games_group_by_category(team_id, "away_team_id", "home_team_id")
    setting_win_loss_as_1_or_0(home_game_hash, "away")
    setting_win_loss_as_1_or_0(away_game_hash, "home")
    home_away_win_loss = combine_home_away_win_loss_results(home_game_hash, away_game_hash)
    team_result = determine_win_or_loss_percentage_per_season(home_away_win_loss)
    team_percentage_pair = determine_best_win_or_loss_percentage(team_result)
    team_id_to_team_name(team_percentage_pair)
  end


  def biggest_team_blowout(team_id)
    team_wins = winning_games(team_id)
    biggest_blowout_game = team_wins.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
    (biggest_blowout_game.home_goals - biggest_blowout_game.away_goals).abs
  end

  def worst_loss(team_id)
    team_losses = losing_games(team_id)
    worst_loss_game = team_losses.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
    (worst_loss_game.home_goals - worst_loss_game.away_goals).abs
  end

  def head_to_head(team_id)
    home_game_hash = home_or_away_games_group_by_category(team_id, "home_team_id", "away_team_id")
    away_game_hash = home_or_away_games_group_by_category(team_id, "away_team_id", "home_team_id")
    setting_win_loss_as_1_or_0(home_game_hash, "home")
    setting_win_loss_as_1_or_0(away_game_hash, "away")
    home_away_win_loss = combine_home_away_win_loss_results(home_game_hash, away_game_hash)
    team_result = determine_win_or_loss_percentage_per_season(home_away_win_loss)
    team_result.inject({}) do |team_hash, team_info|
      team_hash[team_id_name_hash[team_info[0]]] = team_info[1]
      team_hash
    end
  end

  def seasonal_summary(team_id)
    season_games = games_group_by_team(team_id)
    parse_by_season_type(season_games)
    season_games.each do |season, games|
      if games[:preseason]
        non_avg_stat_info = create_preseason_info(games, team_id, :preseason)
      else
        non_avg_stat_info = [0.0, [0], [0]]
      end
      average_goals_scored = calculate_team_win_percentage(non_avg_stat_info[1])
      average_goals_against = calculate_team_win_percentage(non_avg_stat_info[2])
      stat_info = non_avg_stat_info.concat([average_goals_scored, average_goals_against])
      create_regular_preseason_hash(season_games, season, :preseason, stat_info)
      non_avg_stat_info = create_preseason_info(games, team_id, :regular_season)
      average_goals_scored = calculate_team_win_percentage(non_avg_stat_info[1])
      average_goals_against = calculate_team_win_percentage(non_avg_stat_info[2])
      stat_info = non_avg_stat_info.concat([average_goals_scored, average_goals_against])    
      create_regular_preseason_hash(season_games, season, :regular_season, stat_info)
    end
  end
end

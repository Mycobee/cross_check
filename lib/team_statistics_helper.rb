module TeamStatisticsHelper

  def find_team(team_id)
    @league.teams.find do |team|
      team.team_id == team_id
    end
  end

  def all_games_played(team_id)
    @league.games.select do |game|
      game.home_team_id == team_id ||
      game.away_team_id == team_id
    end
  end

  def home_or_away_games(team_id, i_var)
    @league.games.select do |game|
      game.send(i_var.to_sym) == team_id
    end
  end

  def winning_games(team_id)
    @league.games.select do |game|
      game.home_team_id == team_id && game.outcome.include?("home") ||
      game.away_team_id == team_id && game.outcome.include?("away")
    end
  end

  def losing_games(team_id)
    @league.games.select do |game|
      game.home_team_id == team_id && game.outcome.include?("away") ||
      game.away_team_id == team_id && game.outcome.include?("home")
    end
  end

  def all_games_played_group_by_season(team_id)
    all_games_played(team_id).group_by do |game|
      game.season
    end
  end

  def parse_by_season_type(season_games)
    season_games.each do |key, value|
      season_games[key] = value.group_by {|game| game.type == "P" ? :preseason : :regular_season}
    end
  end

  def games_group_by_team(team_id)
    games_by_team = all_games_played(team_id) # line 9
    games_by_team.group_by {|game| game.season} # 
  end

  def home_or_away_games_group_by_category(team_id, i_var1, i_var2)
    home_or_away_games(team_id, i_var1).group_by do |game|
      game.send(i_var2.to_sym)
    end
  end

  def conditional_setting_of_win_loss(game, team_id, string_result_1, string_result_2)
    if game.home_team_id == team_id
      game.outcome.include?(string_result_1) ? 1 : 0
    else
      game.outcome.include?(string_result_2) ? 1 : 0
    end
  end

  def setting_win_loss_as_1_or_0(game_hash, string_result)
    game_hash.each do |opponent, games|
      home_win_loss_array = games.map do |game|
        game.outcome.include?(string_result) ? 1 : 0
      end
      home_win_loss_array = home_win_loss_array.select {|score| score}
      game_hash[opponent] = home_win_loss_array
    end
  end

  def determine_win_or_loss_percentage_per_season(season_hash)
    season_result = {}
    season_hash.each do |season, scores|
      if scores.count == 0
        next
      else
      season_result[season] = (scores.sum.to_f / scores.count).round(2)
      end
    end
    season_result
  end

  def determine_best_win_or_loss_percentage(result_hash)
    result_hash.keys.max_by do |team|
      result_hash[team]
    end
  end

  def calculate_team_win_percentage(win_loss_count)
    (win_loss_count.sum / win_loss_count.count.to_f).round(2)
  end

  def team_id_to_team_name(team_id)
    @league.teams.find {|team| team.team_id == team_id}.team_name
  end

  def combine_home_away_win_loss_results(home_game_hash, away_game_hash)
    home_game_hash.keys.inject({}) do |hash, opponent|
      if home_game_hash[opponent] && away_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent] + away_game_hash[opponent]
      elsif home_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent]
      else hash[opponent] = away_game_hash[opponent]
      end
      hash
    end
  end

  def team_id_name_hash
    @league.teams.inject({}) do |team_hash, team|
      team_hash[team.team_id] = team.team_name
      team_hash
    end
  end

  def own_opponent_goals_by_season_type(games, team_id, season_type, i_var_arr)
    games[season_type].map do |game|
      game.away_team_id == team_id ? game.send(i_var_arr[0]) : game.send(i_var_arr[1])
    end
  end

  def create_regular_preseason_hash(season_games, season_id, season_type, stat_info)
    season_games[season_id][season_type] = {
      :win_percentage => stat_info[0],
      :total_goals_scored => stat_info[1].sum,
      :total_goals_against => stat_info[2].sum,
      :average_goals_scored => stat_info[3],
      :average_goals_against => stat_info[4]
    }
  end

  def create_preseason_info(games, team_id, season_type)
    win_loss_count = games[season_type].map do |game|
      conditional_setting_of_win_loss(game, team_id, "home", "away")
    end
    win_percentage = calculate_team_win_percentage(win_loss_count)
    total_team_goals = own_opponent_goals_by_season_type(games, team_id, season_type, [:away_goals, :home_goals])
    total_opponent_goals = own_opponent_goals_by_season_type(games, team_id, season_type, [:home_goals, :away_goals])
    [win_percentage, total_team_goals, total_opponent_goals]
  end
end

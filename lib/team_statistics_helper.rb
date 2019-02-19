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

end

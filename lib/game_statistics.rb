module GameStatistics
  def highest_total_score
    highest_score_game = @league.games.max_by {|game| (game.away_goals + game.home_goals)}
    highest_score_game.away_goals + highest_score_game.home_goals
  end

  def lowest_total_score
   lowest_score_game =   @league.games.min_by {|game| (game.away_goals + game.home_goals)}
   lowest_score_game.away_goals + lowest_score_game.home_goals
  end

  def biggest_blowout
    biggest_blowout = @league.games.max_by {|game| (game.away_goals - game.home_goals).abs}
    (biggest_blowout.away_goals - biggest_blowout.home_goals).abs
  end

  def percentage_home_wins
    home_win_games = @league.games.select do |game|
       game.outcome.include?("home")
    end
    (home_win_games.count.to_f / @league.games.count).round(2)
  end

  def percentage_visitor_wins
    visitor_win_games = @league.games.select do |game|
      game.outcome.include?("away")
    end
    (visitor_win_games.count.to_f / @league.games.count).round(2)
  end

  def count_of_games_by_season
    season_hash = @league.games.group_by do |game|
      game.season
    end
    season_hash.each do |season, games|
      season_hash[season] = games.count
    end
    season_hash
  end

  def average_goals_per_game
    total_goals = @league.games.map do |game|
      game.away_goals + game.home_goals
    end
    (total_goals.sum / total_goals.count.to_f).round(2)
  end

  def average_goals_by_season
    season_hash = @league.games.group_by do |game|
      game.season
    end
    season_hash.each do |season, games|
      total_scores = season_hash[season].map {|game| game.away_goals + game.home_goals}
      season_hash[season] = (total_scores.sum / total_scores.count.to_f).round(2)
    end
    season_hash
  end
end

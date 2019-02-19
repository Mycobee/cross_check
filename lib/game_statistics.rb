module GameStatistics
  def sum_method(arg1, arg2)
    arg1 + arg2
  end

  def highest_total_score
    highest_score_game = @league.games.max_by {|game| (game.away_goals + game.home_goals)}
    high_away = highest_score_game.away_goals
    high_home = highest_score_game.home_goals
    sum_method(high_away, high_home)
  end

  def lowest_total_score
   lowest_score_game = @league.games.min_by {|game| (game.away_goals + game.home_goals)}
   low_away = lowest_score_game.away_goals
   low_home = lowest_score_game.home_goals
   sum_method(low_away, low_home)
  end

  def biggest_blowout
    biggest_blowout = @league.games.max_by {|game| (game.away_goals - game.home_goals).abs}
    (biggest_blowout.away_goals - biggest_blowout.home_goals).abs
  end

  def filter_home_away_wins(string)
    home_win_games = @league.games.select do |game|
       game.outcome.include?(string)
    end

  end
  def percentage_home_wins
    home_win_games = filter_home_away_wins("home")
    (home_win_games.count.to_f / @league.games.count).round(2)
  end

  def percentage_visitor_wins
    visitor_win_games = filter_home_away_wins("away")
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

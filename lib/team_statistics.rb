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
    season_result = {}
    season_hash.each do |season, scores|
      if scores.count == 0
        next
      else
      season_result[season] = scores.sum.to_f / scores.count
      end
    end
    x = season_result.keys.max_by do |season|
      season_result[season]
    end
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
    season_result = {}
    season_hash.each do |season, scores|
      if scores.count == 0
        next
      else
      season_result[season] = scores.sum.to_f / scores.count
      end
    end
    x = season_result.keys.max_by do |season|
      season_result[season]
    end
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
    home_away_win_loss = home_game_hash.keys.inject({}) do |hash, opponent|
      if home_game_hash[opponent] && away_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent] + away_game_hash[opponent]
      elsif home_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent]
      else hash[opponent] = away_game_hash[opponent]
      end
      hash
    end

    team_result = {}
    home_away_win_loss.each do |team, scores|
      if scores.count == 0
        next
      else
      team_result[team] = scores.sum.to_f / scores.count
      end
    end

    x = team_result.max_by do |team, percentage|
      percentage
    end
    team_name = []
    @league.teams.each do |team|
      if team.team_id == x[0]


        team_name = team.team_name
      end
    end
    return team_name


  end

  def rival(team_id)
    home_game_hash = home_or_away_games_group_by_category(team_id, "home_team_id", "away_team_id")
    away_game_hash = home_or_away_games_group_by_category(team_id, "away_team_id", "home_team_id")
    setting_win_loss_as_1_or_0(home_game_hash, "away")
    setting_win_loss_as_1_or_0(away_game_hash, "home")
    home_away_win_loss = home_game_hash.keys.inject({}) do |hash, opponent|
      if home_game_hash[opponent] && away_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent] + away_game_hash[opponent]
      elsif home_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent]
      else hash[opponent] = away_game_hash[opponent]
      end
      hash
    end

    team_result = {}
    home_away_win_loss.each do |team, scores|
      if scores.count == 0
        next
      else
      team_result[team] = scores.sum.to_f / scores.count
      end
    end

    x = team_result.max_by do |team, percentage|
      percentage
    end

    team_name = []
    @league.teams.each do |team|
      if team.team_id == x[0]
        team_name = team.team_name
      end
    end
    return team_name
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
    #################HELPER METHOD#########################
    home_game_hash = home_or_away_games_group_by_category(team_id, "home_team_id", "away_team_id")
    away_game_hash = home_or_away_games_group_by_category(team_id, "away_team_id", "home_team_id")
    setting_win_loss_as_1_or_0(home_game_hash, "home")
    setting_win_loss_as_1_or_0(away_game_hash, "away")

    home_away_win_loss = home_game_hash.keys.inject({}) do |hash, opponent|
      if home_game_hash[opponent] && away_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent] + away_game_hash[opponent]
      elsif home_game_hash[opponent]
        hash[opponent] = home_game_hash[opponent]
      else hash[opponent] = away_game_hash[opponent]
      end
      hash
    end

    team_result = {}
    home_away_win_loss.each do |team, scores|
      if scores.count == 0
        next
      else
      team_result[team] = (scores.sum.to_f / scores.count).round(2)
      end
    end
    #################HELPER METHOD#########################
    head_to_head = {}
    @league.teams.each do |team|
      team_result.each do |team_id, percentage|
        if team_id == team.team_id
          head_to_head[team.team_name] = percentage
        end
      end
    end
    head_to_head
  end

  def seasonal_summary(team_id)
  games_by_team =  @league.games.select {|game| game.away_team_id == team_id || game.home_team_id == team_id}
  season_games = games_by_team.group_by {|game| game.season}

  season_games.each do |key, value|
    season_games[key] = value.group_by {|game| game.type == "P" ? :preseason : :regular_season}
  end

   season_games.each do |season, games|
     if games[:preseason]
       win_loss_count = games[:preseason].map do |game|
         conditional_setting_of_win_loss(game, team_id, "home", "away")
     end
      win_percentage = (win_loss_count.sum / win_loss_count.count.to_f).round(2)

      total_team_goals = games[:preseason].map do |game|
        if game.away_team_id == team_id
           game.away_goals
        else
          game.home_goals
        end
      end

      total_opponent_goals = games[:preseason].map do |game|
        if game.away_team_id != team_id
           game.away_goals
        else
          game.home_goals
        end
      end

     else
        win_percentage = 0.0
        total_opponent_goals = [0]
        total_team_goals = [0]
    end
      average_goals_scored = (total_team_goals.sum / total_team_goals.count.to_f).round(2)
      average_goals_against = (total_opponent_goals.sum / total_opponent_goals.count.to_f).round(2)

    season_games[season][:preseason] =
      {
      :win_percentage => win_percentage,
      :total_goals_scored => total_team_goals.sum,
      :total_goals_against => total_opponent_goals.sum,
      :average_goals_scored => average_goals_scored,
      :average_goals_against => average_goals_against
      }

        win_loss_count = games[:regular_season].map do |game|
          conditional_setting_of_win_loss(game, team_id, "home", "away")
        end
       win_percentage = (win_loss_count.sum / win_loss_count.count.to_f).round(2)

       total_team_goals = games[:regular_season].map do |game|
         if game.away_team_id == team_id
            game.away_goals
         else
           game.home_goals
         end
       end

       total_opponent_goals = games[:regular_season].map do |game|
         if game.away_team_id != team_id
            game.away_goals
         else
           game.home_goals
         end
       end

       average_goals_scored = (total_team_goals.sum / total_team_goals.count.to_f).round(2)
       average_goals_against = (total_opponent_goals.sum / total_opponent_goals.count.to_f).round(2)

       season_games[season][:regular_season] =
         {
         :win_percentage => win_percentage,
         :total_goals_scored => total_team_goals.sum,
         :total_goals_against => total_opponent_goals.sum,
         :average_goals_scored => average_goals_scored,
         :average_goals_against => average_goals_against
         }

    end
      # require 'pry'; binding.pry
   end


end

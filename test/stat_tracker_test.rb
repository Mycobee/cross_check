require './test/test_helper'
require './lib/stat_tracker'

class TrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/mocks/mock_game.csv',
      teams: './data/mocks/mock_team_info.csv',
      game_teams: './data/mocks/mock_game_teams_stats.csv',
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_file_paths_attribute
   new_stat_tracker = StatTracker.from_csv(@locations)
   assert_instance_of StatTracker, new_stat_tracker
   assert_equal @locations, new_stat_tracker.file_paths
  end

  def test_it_can_create_a_league
    assert_instance_of League, @stat_tracker.league
  end

##########  iteration 2 ##################

  def test_highest_total_score
    actual = @stat_tracker.highest_total_score
    assert_equal 9, actual
  end

  def test_lowest_total_score
    actual = @stat_tracker.lowest_total_score
    assert_equal 1, actual
  end

  def test_biggest_blowout
    actual = @stat_tracker.biggest_blowout
    assert_equal 6, actual
  end

  def test_percentage_home_wins
    actual = @stat_tracker.percentage_home_wins
    assert_equal 68.09, actual
  end

  def test_percentage_visitor_wins
    actual = @stat_tracker.percentage_visitor_wins
    assert_equal 31.91, actual
  end

  def test_count_of_games_by_season
    actual = @stat_tracker.count_of_games_by_season
    expected = {"20122013"=>38, "20132014"=>9}
    assert_equal expected, actual
  end

  def test_average_goals_per_game
    actual = @stat_tracker.average_goals_per_game
    assert_equal 4.7, actual
  end

  def test_average_goals_by_season
    actual = @stat_tracker.average_goals_by_season
    expected = {"20122013"=>4.58, "20132014"=>5.22}
    assert_equal expected, actual
  end
###########################################

##########  iteration 3 ###################

  def test_it_provides_number_of_teams_in_league
    actual = @stat_tracker.count_of_teams
    assert_equal 33, actual
  end

  def test_it_provides_overview_of_each_teams_total_goals
    expected = {
      "26"=>[1, 1, 3, 1, 4, 2, 3],
      "14"=>[5, 3],
      "6"=>[2, 3, 3, 6, 3, 5, 3, 2, 1, 4],
      "3"=>[2, 2, 1, 1, 4, 1],
      "5"=>[1, 0, 0, 0, 1],
      "17"=>[1, 4, 1, 1, 1, 0, 3, 2, 3, 0],
      "18"=>[4], "23"=>[3],
      "16"=>[1, 0, 4, 2, 3, 5, 4, 1, 4, 2, 2, 5, 5],
      "9"=>[4, 1, 6, 6, 3, 5],
      "8"=>[1, 2, 2, 3, 1, 2],
      "30"=>[1, 2, 1, 0, 0, 6, 3, 0],
      "19"=>[0, 3, 1, 2, 2, 2, 2, 6, 2],
      "24"=>[4, 3],
      "2"=>[2, 2, 0],
      "20"=>[5],
      "25"=>[1, 2],
      "29"=>[4],
      "12"=>[0]
    }
    actual = @stat_tracker.total_goals_made_by_team
    assert_equal expected, actual
  end

  def test_it_provides_best_offensive_team
    actual = @stat_tracker.best_offense
    assert_equal "Flames", actual
  end

  def test_it_provides_worst_offensive_team
    actual = @stat_tracker.worst_offense
    assert_equal "Hurricanes", actual
  end

  def test_it_provides_an_overview_of_each_teams_forfeited_goals
    expected = {
      "26"=>[2, 2, 0, 3, 2, 1, 0],
      "14"=>[0, 2],
      "6"=>[2, 2, 1, 4, 1, 0, 1, 1, 0, 2],
      "3"=>[3, 5, 2, 3, 3, 2],
      "5"=>[3, 6, 2, 1, 5],
      "17"=>[4, 1, 1, 0, 4, 4, 2, 3, 4, 6],
      "18"=>[5],
      "23"=>[2],
      "16"=>[1, 4, 3, 2, 1, 3, 1, 1, 2, 3, 0, 1, 2],
      "9"=>[2, 3, 1, 2, 1, 0],
      "8"=>[4, 1, 6, 3, 6, 1],
      "30"=>[2, 5, 2, 3, 5, 3, 4, 0],
      "19"=>[1, 1, 1, 4, 3, 2, 0, 1, 3],
      "24"=>[1, 0],
      "2"=>[4, 3, 6],
      "20"=>[4],
      "25"=>[2, 5],
      "29"=>[0],
      "12"=>[5]
    }
    actual = @stat_tracker.total_goals_forfeited_by_team
    assert_equal expected, actual
  end

  def test_it_shows_best_defensive_team
    actual = @stat_tracker.best_defense
    assert_equal "Blue Jackets", actual
  end

  def test_it_shows_worst_defensive_team
    actual = @stat_tracker.worst_defense
    assert_equal "Predators", actual
  end

  def test_highest_scoring_visitor
    actual = @stat_tracker.highest_scoring_visitor
    assert_equal "Lightning", actual
  end

  def test_highest_scoring_home_team
    actual = @stat_tracker.highest_scoring_home_team
    assert_equal "Flames", actual
  end

  def test_lowest_scoring_visitor
    actual = @stat_tracker.lowest_scoring_visitor
    assert_equal "Penguins", actual
  end

  def test_lowest_scoring_home_team
    actual = @stat_tracker.lowest_scoring_home_team
    assert_equal "Islanders", actual
  end

  def test_winningest_team
    actual = @stat_tracker.winningest_team
    assert_equal "Lightning", actual
  end

  def test_best_fans
    actual = @stat_tracker.best_fans
    assert_equal "Kings", actual
  end

  def test_worst_fans
    locations = {
      games: './data/mocks/mock_game_2.csv',
      teams: './data/mocks/mock_team_info.csv',
      game_teams: './data/mocks/mock_game_teams_stats.csv',
    }
    stat_tracker = StatTracker.from_csv(locations)
    actual = stat_tracker.worst_fans
    assert_equal ["1", "5", "15", "24", "29", "22"], actual
  end
  ###########################################

  ########## iteration 5 ####################

  def test_biggest_bust
    actual = @stat_tracker.biggest_bust('20122013')
    assert_equal 'Red Wings', actual
  end

  def test_biggest_surprise
    assert_equal 'Lightning', @stat_tracker.biggest_surprise('20122013')
  end

  def test_winningest_coach
    locations = {
      games: './data/mocks/mock_game_2.csv',
      teams: './data/mocks/mock_team_info.csv',
      game_teams: './data/mocks/mock_game_teams_stats.csv',
    }
    stat_tracker = StatTracker.from_csv(locations)
    assert_equal 'Bruce Boudreau', stat_tracker.winningest_coach('20122013')
  end

  def test_worst_coach
    locations = {
      games: './data/mocks/mock_game_2.csv',
      teams: './data/mocks/mock_team_info.csv',
      game_teams: './data/mocks/mock_game_teams_stats.csv',
    }
    stat_tracker = StatTracker.from_csv(locations)
    assert_equal "Dan Bylsma", stat_tracker.worst_coach('20122013')
  end

  def test_most_accurate_team
    locations = {
      games: './data/mocks/mock_game_2.csv',
      teams: './data/mocks/mock_team_info.csv',
      game_teams: './data/mocks/mock_game_teams_stats.csv',
    }
    stat_tracker = StatTracker.from_csv(locations)
    assert_equal 'Senators', stat_tracker.most_accurate_team('20122013')

  end

  def test_most_hits

    assert_equal "Blackhawks", @stat_tracker.most_hits('20122013')
  end

  def test_least_hits
    assert_equal "Ducks", @stat_tracker.least_hits('20122013')
  end

  def test_power_play_goal_percentage
    assert_equal 0.2, @stat_tracker.power_play_goal_percentage('20122013')
  end

  # def test_total_season_win_loss
  #   assert_equal  , stat_tracker.total_season_win_loss("20122013")
  # end

  def test_hits_records
    expected = {
                "3"=>179,
                "6"=>271,
                "5"=>150,
                "17"=>259,
                "16"=>299,
                "9"=>181,
                "8"=>173,
                "30"=>165,
                "26"=>241,
                "19"=>238,
                "24"=>61
                }
    assert_equal expected, @stat_tracker.hits_records('20122013')
  end

  def test_least_accurate_team
    assert_equal "Penguins", @stat_tracker.least_accurate_team('20122013')
  end
  ###########################################
  #######Iteration 4 ########################

  def test_team_info

    actual = @stat_tracker.team_info("3")
    expected = {
      "team_id" => "3",
      "franchise_id" => "10",
      "short_name" => "NY Rangers",
      "team_name" => "Rangers",
      "abbreviation" => "NYR",
      "link" => "/api/v1/teams/3"
    }

    assert_equal expected , actual
  end

  def test_best_season
    actual = @stat_tracker.best_season("3")
    assert_equal "20122013", actual
  end

  def test_worst_season
    actual = @stat_tracker.worst_season("3")


    assert_equal "20132014", actual
  end

  def test_average_win_percenrage
    actual = @stat_tracker.average_win_percentage("3")

    assert_equal 0.17, actual
  end

  def test_most_goals_scored
    actual = @stat_tracker.most_goals_scored("3")

    assert_equal 4, actual
  end

  def test_fewest_goals_scored
    actual = @stat_tracker.fewest_goals_scored("3")

    assert_equal 1, actual
  end

  def test_favorite_opponent
    actual = @stat_tracker.favorite_opponent("3")

    assert_equal "Bruins", actual
  end

  def test_rival
    actual = @stat_tracker.rival("3")

    assert_equal "Blues", actual
  end

  def test_biggest_team_blowout
    actual = @stat_tracker.biggest_team_blowout("3")

    assert_equal 1, actual
  end

  def test_worst_loss
    actual = @stat_tracker.worst_loss("3")

    assert_equal 3, actual
  end

  def test_head_to_head
    actual = @stat_tracker.head_to_head("3")
    expected = {"Bruins"=>0.2, "Blues" => 0.0}
    assert_equal expected,  actual

  end

  def test_seasonal_summary
    actual = @stat_tracker.seasonal_summary("6")
    expected = {
                "20122013"=>{
                  :preseason=>{
                    :win_percentage=>0.89,
                       :total_goals_scored=>28,
                       :total_goals_against=>12,
                       :average_goals_scored=>3.11,
                       :average_goals_against=>1.33
                  },
                  :regular_season=>{
                    :win_percentage=>1.0,
                        :total_goals_scored=>4,
                        :total_goals_against=>2,
                        :average_goals_scored=>4.0,
                        :average_goals_against=>2.0
                   }
                 }
               }
    assert_equal expected, actual
  end

end

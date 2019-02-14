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
    @stat_tracker.create_league
    assert_instance_of League, @stat_tracker.league
  end

##########  iteration 2 ##################

  def test_highest_total_score
    actual = @stat_tracker.highest_total_score
    assert_equal 7, actual
  end

  def test_lowest_total_score
    actual = @stat_tracker.lowest_total_score
    assert_equal 1, actual
  end

  def test_biggest_blowout
    actual = @stat_tracker.biggest_blowout
    assert_equal 5, actual
  end

  def test_percentage_home_wins
    actual = @stat_tracker.percentage_home_wins
    assert_equal 70.59, actual
  end

  def test_percentage_visitor_wins
    actual = @stat_tracker.percentage_visitor_wins
    assert_equal 29.41, actual
  end

  def test_count_of_games_by_season
    actual = @stat_tracker.count_of_games_by_season
    expected = {"20122013"=>34}
    assert_equal expected, actual
  end

  def test_average_goals_per_game
    actual = @stat_tracker.average_goals_per_game
    assert_equal 4.53, actual
  end

  def test_average_goals_by_season
    actual = @stat_tracker.average_goals_by_season
    expected  ={"20122013"=>4.53}
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
      "26"=>[1, 1, 3, 1, 4, 2], 
      "6"=>[2, 3, 3, 6, 3, 5, 3, 2, 1], 
      "3"=>[2, 2, 1, 1, 4], 
      "5"=>[1, 0, 0, 1], 
      "17"=>[1, 4, 1, 1, 1, 3, 2, 3, 0], 
      "16"=>[1, 0, 4, 2, 3, 4, 1, 4, 2, 2, 5, 5], 
      "9"=>[4, 1, 6, 6, 3], 
      "8"=>[1, 2, 2, 3, 1], 
      "30"=>[1, 2, 1, 3, 0], 
      "19"=>[0, 3, 1, 2, 2, 2], 
      "24"=>[4, 3]
    }
    actual = @stat_tracker.total_goals_made_by_team
    assert_equal expected, actual
  end

  def test_it_provides_best_offensive_team
    actual = @stat_tracker.best_offense
    assert_equal "Senators", actual
  end

  def test_it_provides_worst_offensive_team
    actual = @stat_tracker.worst_offense
    assert_equal "Penguins", actual
  end

  def test_it_provides_an_overview_of_each_teams_forfeited_goals
    expected = {
      "26"=>[2, 2, 0, 3, 2, 1], 
      "6"=>[2, 2, 1, 4, 1, 0, 1, 1, 0], 
      "3"=>[3, 5, 2, 3, 3], 
      "5"=>[3, 6, 2, 1], 
      "17"=>[4, 1, 1, 0, 4, 4, 2, 3, 4], 
      "16"=>[1, 4, 3, 2, 1, 3, 1, 1, 2, 3, 0, 1], 
      "9"=>[2, 3, 1, 2, 1], 
      "8"=>[4, 1, 6, 3, 6], 
      "30"=>[2, 5, 2, 3, 5], 
      "19"=>[1, 1, 1, 4, 3, 2], 
      "24"=>[1, 0]
    }
    actual = @stat_tracker.total_goals_forfeited_by_team
    assert_equal expected, actual
  end

  def test_it_shows_best_defensive_team
    actual = @stat_tracker.best_defense
    assert_equal "Ducks", actual
  end

  def test_it_shows_worst_defensive_team
    actual = @stat_tracker.worst_defense
    assert_equal "Canadiens", actual
  end

  def test_highest_scoring_visitor
    actual = @stat_tracker.highest_scoring_visitor
    assert_equal "Ducks", actual
  end

  def test_highest_scoring_home_team
    actual = @stat_tracker.highest_scoring_home_team
    assert_equal "Senators", actual
  end

  def test_lowest_scoring_visitor
    actual = @stat_tracker.lowest_scoring_visitor
    assert_equal "Penguins", actual
  end

  def test_lowest_scoring_home_team
    actual = @stat_tracker.lowest_scoring_home_team
    assert_equal "Penguins", actual
  end

  def test_winningest_team
    actual = @stat_tracker.winningest_team
    assert_equal "Ducks", actual
  end

  def test_best_fans
    actual = @stat_tracker.best_fans
    assert_equal "Kings", actual
  end

  def test_worst_fans
    actual = @stat_tracker.worst_fans
    assert_equal [], actual
  end

  ###########################################


  ################Iteration 5#################

  def test_biggest_bust
    actual = @stat_tracker.biggest_bust("20122013")
    assert_equal "Islanders", actual
  end

  def test_biggest_surprise
    actual = @stat_tracker.biggest_surprise("20122013")
    assert_equal "Lightning", actual
  end

  def test_winningest_coach
    actual = @stat_tracker.winningest_coach("20122013")
    assert_equal "Claude Julien", actual
  end

  def test_worst_coach
    actual = @stat_tracker.worst_coach("20122013")
    assert_equal "Jack Capuano", actual
  end

  def test_most_accurate_team
    actual = @stat_tracker.most_accurate_team("20122013")
    assert_equal "Senators", actual
  end

  def test_least_accurate_team
    actual = @stat_tracker.least_accurate_team("20122013")
    assert_equal "Penguins", actual
  end

  def test_most_hits
    actual = @stat_tracker.most_hits("20122013")
    assert_equal "Blackhawks", actual
  end

  def test_least_hits
    actual = @stat_tracker.least_hits("20122013")
    assert_equal "Ducks", actual
  end
  ###########################################

end
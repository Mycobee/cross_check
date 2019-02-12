require './test/test_helper'
require './lib/stat_tracker'

class TrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/mocks/mock_game.csv',
      teams: './data/mocks/mock_team_info.csv',
    }
    @stat_tracker = StatTracker.new(@locations)
    @stat_tracker.load_csv
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_file_paths_attribute
   new_stat_tracker = StatTracker.from_csv(@locations)
   assert_instance_of StatTracker, new_stat_tracker
   assert_equal @locations, new_stat_tracker.file_paths
  end

  def test_it_imports_csv_files
    new_stat_tracker = StatTracker.from_csv(@locations)
    new_stat_tracker.load_csv

    @locations.keys.each do |type|
      state_value = new_stat_tracker.instance_variable_get("@#{type}")
      assert_instance_of CSV, state_value
    end
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
    assert_equal 5, actual
  end
###########################################

##########  iteration 3 ###################

  def test_it_provides_number_of_teams_in_league
    actual = @stat_tracker.count_of_teams
    assert_equal 33, actual
  end

  def test_it_provides_overview_of_each_teams_total_goals
    expected = {
      "Kings"=>[1, 1, 1, 4, 3, 2],
      "Bruins"=>[3, 5, 2, 3, 3, 3, 6, 2, 1],
      "Rangers"=>[2, 2, 1, 4, 1],
      "Penguins"=>[0, 1, 1, 0],
      "Red Wings"=>[1, 4, 3, 2, 1, 3, 1, 1, 0],
      "Blackhawks"=>[4, 1, 1, 0, 4, 4, 2, 2, 5, 2, 3, 5],
      "Senators"=>[4, 1, 6, 3, 6],
      "Canadiens"=>[2, 3, 1, 2, 1],
      "Wild"=>[1, 2, 3, 0, 1],
      "Blues"=>[2, 2, 0, 3, 2, 1],
      "Ducks"=>[3, 4]
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
      "Kings"=>[2, 2, 0, 3, 2, 1],
      "Bruins"=>[2, 2, 1, 4, 1, 0, 1, 1, 0],
      "Rangers"=>[3, 5, 2, 3, 3],
      "Penguins"=>[3, 6, 2, 1],
      "Red Wings"=>[4, 1, 1, 0, 4, 4, 2, 3, 4],
      "Blackhawks"=>[1, 4, 3, 2, 1, 3, 1, 1, 2, 3, 0, 1],
      "Senators"=>[2, 3, 1, 2, 1],
      "Canadiens"=>[4, 1, 6, 3, 6],
      "Wild"=>[2, 5, 2, 3, 5],
      "Blues"=>[1, 1, 1, 4, 3, 2],
      "Ducks"=>[1, 0]
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
    assert_equal "Penguins", actual
  end
  ########################################

end

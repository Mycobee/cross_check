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

  def test_it_provides_number_of_teams_in_league
    actual = @stat_tracker.count_of_teams
    assert_equal 33, actual
  end

  def test_it_provides_overview_of_each_teams_total_goals
    expected = {
      "Los Angeles"=>[1, 1, 1, 4, 3, 2],
      "Boston"=>[3, 5, 2, 3, 3, 3, 6, 2, 1],
      "NY Rangers"=>[2, 2, 1, 4, 1], 
      "Pittsburgh"=>[0, 1, 1, 0], 
      "Detroit"=>[1, 4, 3, 2, 1, 3, 1, 1], 
      "Chicago"=>[4, 1, 1, 0, 4, 4, 2, 2, 5, 2, 3, 5], 
      "Ottawa"=>[4, 1, 6, 3, 6], 
      "Montreal"=>[2, 3, 1, 2, 1], 
      "Minnesota"=>[1, 2, 3, 0, 1], 
      "St Louis"=>[2, 2, 0, 3, 2, 1], 
      "Anaheim"=>[3]
    }
    actual = @stat_tracker.total_goals_made_by_team
    assert_equal expected, actual
  end

  def test_it_provides_best_offensive_team
    actual = @stat_tracker.best_offense
    assert_equal "Ottawa", actual
  end

  def test_it_provides_worst_offensive_team
    actual = @stat_tracker.worst_offense
    assert_equal "Pittsburgh", actual
  end

  def test_it_provides_an_overview_of_each_teams_forfeited_goals
    expected = {
      "Los Angeles"=>[2, 2, 0, 3, 2, 1], 
      "Boston"=>[2, 2, 1, 4, 1, 0, 1, 1, 0], 
      "NY Rangers"=>[3, 5, 2, 3, 3], 
      "Pittsburgh"=>[3, 6, 2, 1], 
      "Detroit"=>[4, 1, 1, 0, 4, 4, 2, 3], 
      "Chicago"=>[1, 4, 3, 2, 1, 3, 1, 1, 2, 3, 0, 1], 
      "Ottawa"=>[2, 3, 1, 2, 1], 
      "Montreal"=>[4, 1, 6, 3, 6], 
      "Minnesota"=>[2, 5, 2, 3, 5], 
      "St Louis"=>[1, 1, 1, 4, 3, 2], 
      "Anaheim"=>[1]
    }
    actual = @stat_tracker.total_goals_forfeited_by_team
    assert_equal expected, actual
  end

  def test_it_shows_best_defensive_team
    actual = @stat_tracker.best_defense
    assert_equal "Anaheim", actual
  end

  def test_it_shows_worst_defensive_team
    actual = @stat_tracker.worst_defense
    assert_equal "Montreal", actual
  end

  def test_highest_scoring_visitor
    actual = @stat_tracker.highest_scoring_visitor
    assert_equal "Ottawa", actual
  end

  def test_highest_scoring_home_team
    actual = @stat_tracker.highest_scoring_home_team
    assert_equal "", actual
  end
end

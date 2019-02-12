require './test/test_helper'
require './lib/stat_tracker'

class TrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/mocks/mock_game.csv',
      teams: './data/mocks/mock_team_info.csv',
    }
    @stat_tracker = StatTracker.new(@locations)
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
    @stat_tracker.load_csv
    @stat_tracker.create_league
    assert_instance_of League, @stat_tracker.league
  end

  def test_it_provides_overview_of_each_teams_total_goals
    @stat_tracker.load_csv
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
    @stat_tracker.load_csv
    actual = @stat_tracker.best_offense
    assert_equal "Ottawa", actual
  end

  def test_it_provides_worst_offensive_team
    @stat_tracker.load_csv
    actual = @stat_tracker.worst_offense
    assert_equal "Pittsburgh", actual
  end

  def test_it_shows_best_defensive_team
    @stat_tracker.load_csv
    actual = @stat_tracker.best_defense
    assert_equal "", actual
  end

end

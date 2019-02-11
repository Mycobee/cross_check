require './test/test_helper'
require './lib/stat_tracker'

class TrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/mocks/mock_game.csv',
      teams: './data/mocks/mock_team_info.csv',
      game_teams: './data/mocks/mock_game_teams_stats.csv'
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

end

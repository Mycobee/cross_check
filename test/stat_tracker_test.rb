require './test/test_helper'
require './lib/stat_tracker'

class TrackerTest < Minitest::Test

  def setup
    @locations = {
      games: 'game_path',
      teams: 'team_path',
      game_teams: 'game_teams_path'
      }

    @stat_tracker = StatTracker.new(@locations)

    @teams = {team_id: 1, franchiseId:,"shortName","teamName","abbreviation","link"}

    @games

    @game_teams
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

    assert_equal ,  @stat_tracker.from_csv
  end


end

require './test/test_helper'
require './lib/stat_tracker'
require './lib/teams_info'
require './data/mocks/mock_data'

class TeamsInfoTest < Minitest::Test
  def setup
    @data_set = StatTracker.from_csv({
      teams: './data/mocks/mock_team_info.csv'
    })
    @data_set.load_csv
    @teams = TeamsInfo.new(@data_set.teams)
  end

  def test_it_exists
    assert_instance_of TeamsInfo, @teams
  end

  def test_it_has_a_list_of_teams
    @teams.teams_list.each do |team|
      assert_instance_of Team, team
    end 

    assert_equal 1, @teams.teams_list.count
  end
  
end
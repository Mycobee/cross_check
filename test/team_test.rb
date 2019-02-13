require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'
require './data/mocks/mock_data'

class TeamTest < Minitest::Test
  include MockData
  def setup
    data_set = StatTracker.from_csv({
      games: './data/mocks/mock_game.csv',
      teams: './data/mocks/mock_team_info.csv'
    })
    data_set.load_csv
    @team = data_set.league.teams.first
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_team_attributes
    mock_team.each do |key, value|
      expected = @team.instance_variable_get("@#{key}")
      assert_equal value, expected
    end
  end
end

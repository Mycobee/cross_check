require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'
require './data/mocks/mock_data'

class TeamTest < Minitest::Test
  include MockData
  def setup
    @team = Team.new(mock_team)
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

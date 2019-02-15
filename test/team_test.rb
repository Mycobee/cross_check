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

  def test_it_has_a_franchise_id
    assert_equal "23", @team.franchise_id
  end

  def test_it_has_a_short_name
    assert_equal "New Jersey", @team.short_name
  end

  def test_it_shows_team_name
    assert_equal "Devils", @team.team_name
  end

  def test_it_has_abbreviation
    assert_equal "NJD", @team.abbreviation
  end

  def test_it_has_link
    assert_equal "/api/v1/teams/1", @team.link
  end
end

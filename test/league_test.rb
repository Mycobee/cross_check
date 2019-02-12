require './test/test_helper'
require './lib/stat_tracker'
require './lib/league'

class LeagueTest < Minitest::Test
  include MockData
  def setup
    @data_set = StatTracker.from_csv({
      games: './data/mocks/mock_game.csv',
      teams: './data/mocks/mock_team_info.csv'
    })
    @data_set.load_csv
    @league = League.new(@data_set.games, @data_set.teams)
  end

  def test_it_exists
    assert_instance_of League, @league
  end

  def test_it_initializes_with_games
    assert_instance_of Games, @league.games
  end

  def test_it_initializes_with_teams
    assert_instance_of TeamsInfo, @league.teams
  end
end
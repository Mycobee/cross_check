require './test/test_helper'
require './lib/stat_tracker'
require './lib/league'

class LeagueTest < Minitest::Test
  include MockData
  def setup
    data_set = StatTracker.from_csv({
      games: './data/mocks/mock_game.csv',
      teams: './data/mocks/mock_team_info.csv'
    })
    data_set.load_csv
    @league = data_set.league
  end

  def test_it_exists
    assert_instance_of League, @league
  end

  def test_it_initializes_with_games
    @league.games.each do |game|
      assert_instance_of Game, game
    end
  end

  def test_it_initializes_with_teams
    @league.teams.each do |team|
      assert_instance_of Team, team
    end
  end
end
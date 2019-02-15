require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'
require './data/mocks/mock_data'

class GameTest < Minitest::Test
  include MockData

  def setup
    @game = Game.new(mock_game)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_game_id
    assert_equal "2012030221", @game.game_id
  end

  def test_it_has_season
    assert_equal "20122013", @game.season
  end

  def test_it_has_date_time
    assert_equal "2013-05-16", @game.date_time
  end

  def test_it_has_type
    assert_equal "P", @game.type
  end

  def test_it_has_away_team_id
    assert_equal "3", @game.away_team_id
  end

  def test_it_has_away_goals
    assert_equal 2, @game.away_goals
  end

  def test_it_has_home_goals
    assert_equal 3, @game.home_goals
  end

  def test_it_has_outome
    assert_equal "home win OT", @game.outcome
  end

  def test_it_has_home_rink_side_start
    assert_equal "left", @game.home_rink_side_start
  end

  def test_it_has_venue
    assert_equal "TD Garden", @game.venue
  end

  def test_it_has_venue_link
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_it_has_venue_time_zone_id
    assert_equal "America/New_York", @game.venue_time_zone_id
  end

  def test_it_has_venue_time_zone_offset
    assert_equal "-4", @game.venue_time_zone_offset
  end

  def test_it_has_venue_time_zone_tz
    assert_equal "EDT", @game.venue_time_zone_tz
  end
end

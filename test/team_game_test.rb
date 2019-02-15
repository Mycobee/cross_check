require './test/test_helper'
require './lib/stat_tracker'
require './lib/team_game'
require './data/mocks/mock_data'

class TeamGameTest < Minitest::Test
  include MockData
  
  def setup
    @team_game = TeamGame.new(mock_team_game)
  end

  def test_it_exists
    assert_instance_of TeamGame, @team_game
  end

  def test_it_has_game_id
    assert_equal "2012030221", @team_game.game_id
  end

  def test_it_has_team_id
    assert_equal "3", @team_game.team_id
  end

  def test_it_has_home_or_away
    assert_equal "away", @team_game.home_or_away
  end

  def test_it_shows_win_status
    assert_equal "FALSE", @team_game.won
  end

  def test_it_has_settled_in
    assert_equal "OT", @team_game.settled_in
  end

  def test_it_has_head_coach
    assert_equal "John Tortorella", @team_game.head_coach
  end

  def test_it_has_goals
    assert_equal 2, @team_game.goals
  end

  def test_it_has_shots
    assert_equal 35, @team_game.shots
  end

  def test_it_has_hits
    assert_equal 44, @team_game.hits
  end

  def test_it_has_pim
    assert_equal "8", @team_game.pim
  end

  def test_it_has_power_play_oppurtunities
    assert_equal "3", @team_game.power_play_opportunities
  end

  def test_it_has_power_play_goals
    assert_equal 0, @team_game.power_play_goals
  end

  def test_it_has_face_off_win_percentage
    assert_equal "44.8", @team_game.face_off_win_percentage

  end

  def test_has_give_aways
    assert_equal "17", @team_game.give_aways
  end

  def test_it_has_take_aways
    assert_equal "7", @team_game.take_aways
  end
end

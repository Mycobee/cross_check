require './test/test_helper'
require './lib/stat_tracker'
require './lib/games'

class GamesTest < Minitest::Test
  def setup
    @data_set = StatTracker.from_csv({games: './data/mocks/mock_game.csv'})
    @data_set.load_csv
    @games = Games.new(@data_set.games)
  end

  def test_it_exists
    assert_instance_of Games, @games
  end

  def test_it_has_a_list_of_games
    @games.game_list.each do |game|
      assert_instance_of Game, game
    end

    assert_equal 1, @games.game_list.count
  end
end
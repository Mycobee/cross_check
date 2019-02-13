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

  def test_it_has_attributes
    mock_game.each do |key, value|
      actual = @game.instance_variable_get("@#{key}")
      assert_equal value, actual
    end
  end
end

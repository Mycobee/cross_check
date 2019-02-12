require './test/test_helper'
require './lib/stat_tracker'
require 'csv'
require './lib/game'
require './data/mocks/mock_assertions'

class GameTest < Minitest::Test
  include MockAssertions

  def setup
    @data_set = StatTracker.from_csv({games: './data/mocks/mock_game.csv'})
    @data_set.load_csv
    @games = @data_set.games.map do |value|
      Game.new(value)
    end
  end

  def test_it_exists
    assert_instance_of Game, @games.first
  end

  def test_it_has_attributes
    mock_game.each do |key, value|
      actual = @games.first.instance_variable_get("@#{key}")
      assert_equal value, actual
    end
  end
end

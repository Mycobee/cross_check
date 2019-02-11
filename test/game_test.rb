require './test/test_helper'
require './lib/stat_tracker'
require 'csv'
require './lib/game'

class GameTest < Minitest::Test


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
    instance_variables = [:game_id,
    :season,
    :type,
    :date_time,
    :away_team_id,
    :home_team_id,
    :away_goals,
    :home_goals,
    :outcome,
    :home_rink_side_star,
    :venue,
    :venue_link,
    :venue_time_zone_id,
    :venue_time_zone_offset,
    :venue_time_zone_tz]
    instance_variables.each do |key|
      value = @games.first.instance_variable_get("@#{key}")
      assert_equal []
    end
    end
  end
end

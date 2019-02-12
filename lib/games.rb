require './lib/game'

class Games
  attr_reader :game_list
  
  def initialize(game_list)
    @game_list = game_list.map {|game_info| Game.new(game_info)}
  end
end
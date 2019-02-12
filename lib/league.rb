require './lib/game'
require './lib/team'

class League
  attr_reader :games,
              :teams

  def initialize(games, teams)
    @games = games.map{ |game| Game.new(game) }
    @teams = teams.map { |team| Team.new(team) }
  end
end
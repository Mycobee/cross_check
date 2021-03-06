require_relative 'game'
require_relative 'team'
require_relative 'team_game'

class League
  attr_reader :games,
              :teams,
              :team_games

  def initialize(games, teams, team_games)
    @team_games = team_games.map {|team_game| TeamGame.new(team_game)}
    @games = games.map{ |game| Game.new(game) }
    @teams = teams.map { |team| Team.new(team) }
  end
end

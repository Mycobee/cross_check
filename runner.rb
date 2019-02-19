require './lib/stat_tracker'

game_path = './data/game.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
stat_tracker.load_csv
# stat_tracker.average_goals_by_season
stat_tracker.head_to_head("18")

# require 'pry'; binding.pry

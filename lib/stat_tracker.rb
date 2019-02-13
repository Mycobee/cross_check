require 'csv'
require './lib/league'
require './lib/league_statistics'
require './lib/game_statistics'
require './lib/season_statistics'


class StatTracker
  include LeagueStatistics
  include GameStatistics
  include SeasonStatistics

  attr_reader :file_paths,
              :league

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(files)
    stat_tracker = new(files)
    stat_tracker.load_csv
    stat_tracker
  end

  def load_csv
    csv_files = []
    @file_paths.each do |_, file_path|
      data_set = CSV.open(file_path, headers: true, header_converters: :symbol)
      csv_files << data_set
    end
    create_league(*csv_files)
    csv_files
  end

  def create_league(games, teams, team_games)
    @league = League.new(games, teams, team_games)
  end
end

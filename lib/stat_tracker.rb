require 'csv'
require_relative './league'
require_relative './league_statistics'
require_relative './game_statistics'
require_relative './season_statistics'
require_relative './team_statistics'


class StatTracker
  include LeagueStatistics
  include GameStatistics
  include SeasonStatistics
  include TeamStatistics

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

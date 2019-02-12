require 'csv'
require './lib/league'
require './lib/league_statistics'


class StatTracker
  include LeagueStatistics

  attr_reader :file_paths,
              :teams,
              :games,
              :league

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(files)
    new(files)
  end

  def load_csv
    @file_paths.each do |type, file_path|
      data_set = CSV.open(file_path, headers: true, header_converters: :symbol)
      instance_variable_set("@#{type}", data_set)
    end
    create_league
  end

  def create_league
    @league = League.new(@games, @teams)
  end
end

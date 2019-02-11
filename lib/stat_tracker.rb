require 'csv'

class StatTracker
  attr_reader :file_paths, 
              :teams, 
              :games, 
              :game_teams

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
  end
end

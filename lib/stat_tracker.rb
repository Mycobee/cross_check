require 'csv'

class StatTracker
  attr_reader :file_paths

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end


  def load_csv
    @file_paths.each do |keys, values|
      x = CSV.read values
      headers = x.shift.map {|header| header.to_sym}
      body =
x.map

  end
  end
end

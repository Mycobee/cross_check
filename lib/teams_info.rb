require './lib/team'

class TeamsInfo
  attr_reader :teams_list
  
  def initialize(teams_list)
    @teams_list = teams_list.map { |team| Team.new(team) }
  end
end
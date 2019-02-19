module TeamStatisticsHelper

def find_team(team_id)
  @league.teams.find do |team|
    team.team_id == team_id
  end
end

end 

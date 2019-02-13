class TeamGame
  attr_reader :game_id, 
              :team_id,
              :home_or_away, 
              :won, 
              :settled_in, 
              :head_coach, 
              :goals, 
              :shots, 
              :hits, 
              :pim, 
              :power_play_opportunities, 
              :power_play_goals, 
              :face_off_win_percentage, 
              :give_aways, 
              :take_aways
              
  def initialize(team_game_info)
    @game_id = team_game_info[:game_id] 
    @team_id = team_game_info[:team_id]
    @home_or_away = team_game_info[:HoA]
    @won = team_game_info[:won]
    @settled_in = team_game_info[:settled_in]
    @head_coach = team_game_info[:head_coach]
    @goals = team_game_info[:goals]
    @shots = team_game_info[:shots]
    @hits = team_game_info[:hits]
    @pim = team_game_info[:pim]
    @power_play_opportunities = team_game_info[:powerPlayOpportunities]
    @power_play_goals = team_game_info[:powerPlayGoals]
    @face_off_win_percentage = team_game_info[:faceOffWinPercentage]
    @give_aways = team_game_info[:giveaways]
    @take_aways = team_game_info[:takeaways]
  end
end
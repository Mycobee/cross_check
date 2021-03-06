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
    @home_or_away = team_game_info[:hoa]
    @won = team_game_info[:won]
    @settled_in = team_game_info[:settled_in]
    @head_coach = team_game_info[:head_coach]
    @goals = team_game_info[:goals].to_i
    @shots = team_game_info[:shots].to_i
    @hits = team_game_info[:hits].to_i
    @pim = team_game_info[:pim]
    @power_play_opportunities = team_game_info[:powerplayopportunities]
    @power_play_goals = team_game_info[:powerplaygoals].to_i
    @face_off_win_percentage = team_game_info[:faceoffwinpercentage]
    @give_aways = team_game_info[:giveaways]
    @take_aways = team_game_info[:takeaways]
  end
end

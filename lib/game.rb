class Game

  def initialize(params)
    @game_id = params[:game_id]
    @season = params[:season]
    @type = params[:type]
    @date_time = params[:date_time]
    @away_team_id = params[:away_team_id]
    @home_team_id = params[:home_team_id]
    @away_goals = params[:away_goals]
    @home_goals = params[:home_goals]
    @outcome = params[:outcome]
    @home_rink_side_start = params[:home_rink_side_start]
    @venue = params[:venue]
    @venue_link = params[:venue_link]
    @venue_time_zone_id = params[:venue_time_zone_id]
    @venue_time_zone_offset = params[:venue_time_zone_offset]
    @venue_time_zone_tz = params[:venue_time_zone_tz]

  end


end

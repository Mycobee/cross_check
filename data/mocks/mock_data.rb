module MockData
  def mock_game
    {
      game_id: "2012030221",
      season: "20122013",
      date_time: "2013-05-16",
      type: "P",
      away_team_id: "3",
      home_team_id: "6",
      away_goals: 2,
      home_goals: 3,
      outcome: "home win OT",
      home_rink_side_start: "left",
      venue: "TD Garden",
      venue_link: "/api/v1/venues/null",
      venue_time_zone_id: "America/New_York",
      venue_time_zone_offset: "-4",
      venue_time_zone_tz: "EDT"
    }
  end

  def mock_team
    {
      team_id: "1",
      franchise_id: "23",
      short_name: "New Jersey",
      team_name: "Devils",
      abbreviation: "NJD",
      link: "/api/v1/teams/1"
    }
  end
end
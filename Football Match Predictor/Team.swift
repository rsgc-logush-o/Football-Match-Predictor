//
//  Team.swift
//  Football Match Predictor
//
//  Created by Student on 2017-03-31.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation

//This structure holds information for individual teams
struct Team
{
    //Stores the team name
    var name = ""
    //Stores the wins losses and games played
    var wins : Float = 0
    var losses : Float = 0
    var gamesPlayed : Float = 0
    
    //Stores the total points scored by the team, and points scored against the team
    var pointsScored : Float = 0
    var pointsAgainst : Float = 0
    
    //This array stores all of the matches played by this team
   
    
    //This stores the teams statistics in another structure
    var stats : TeamStats
    
}

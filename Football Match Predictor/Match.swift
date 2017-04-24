//
//  Match.swift
//  Football Match Predictor
//
//  Created by Student on 2017-03-31.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
//This structure holds information for matches
struct Match
{
    //Stores the opposing team in the match
    var homeTeamID : Int
    
    //Stores the teams' score
    var awayTeamID : Int
    //Stores the opposing teams score for the match
    var homeTeamScore : Float
    
    var awayTeamScore : Float
    
    var gameID : Int
}

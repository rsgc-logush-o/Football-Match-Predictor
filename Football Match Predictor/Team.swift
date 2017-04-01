//
//  Team.swift
//  Football Match Predictor
//
//  Created by Student on 2017-03-31.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation

struct Team
{
    var name = ""
    var wins : Float = 0
    var losses : Float = 0
    var gamesPlayed : Float = 0
    
    var pointsScored : Float = 0
    var pointsAgainst : Float = 0
    
    var avgPointsScored : Float = 0
    var avgPointsAgainst : Float = 0
    
    var games : [Match] = []
    var scoresFor : [Float] = []
    var scoresAgainst : [Float] = []
    
    var avgPointsAgainstAvgDefense : Float = 0
    var avgDefenseAgainstAvgPoints : Float = 0

}

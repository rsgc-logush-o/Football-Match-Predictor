//
//  TeamStats.swift
//  Football Match Predictor
//
//  Created by Student on 2017-03-31.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
//This structure holds data for matches that have been played
struct TeamStats
{
    //The average points scored and average points allowed
    var avgPointsScored : Float = 0
    var avgPointsAgainst : Float = 0
    
    //These store the average overperformance/underperformance by the teams offense/defense
    var avgPointsAgainstAvgDefense : Float = 0
    var avgDefenseAgainstAvgPoints : Float = 0
    
}

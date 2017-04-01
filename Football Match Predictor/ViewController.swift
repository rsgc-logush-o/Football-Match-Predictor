//
//  ViewController.swift
//  Football Match Predictor
//
//  Created by Student on 2017-02-28.
//  Copyright © 2017 Student. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: Properties
    
    
    
    
    // MARK: viewDidLoad
    // Runs once
    
    
   
    
    
    
    
    
    
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Other functions

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}




func statCalculations(teamToCalculate : Team) -> TeamStats
{
    var bufferTeam = TeamStats()
    
    
    
    
    bufferTeam.avgPointsScored = teamToCalculate.pointsScored / teamToCalculate.gamesPlayed
    bufferTeam.avgPointsAgainst = teamToCalculate.pointsAgainst / teamToCalculate.gamesPlayed
    
    bufferTeam.avgPointsAgainstAvgDefense = findAvgPointsAgainstAvgDefense(teamToCalculate: teamToCalculate)
    
    bufferTeam.avgDefenseAgainstAvgPoints = findAvgDefenseAgainstAvgPointsAgainst(teamToCalculate: teamToCalculate)
    
    return bufferTeam
    
}




func startMatch(homeTeam : Team, awayTeam : Team, isNeutral : Bool) -> Team
{
    var homeTeamScore : Float = 0
    var awayTeamScore : Float = 0
    
    
    
    homeTeamScore = ((homeTeam.stats.avgPointsScored - awayTeam.stats.avgDefenseAgainstAvgPoints) + (awayTeam.stats.avgPointsAgainst + homeTeam.stats.avgPointsAgainstAvgDefense)) / 2
    
    awayTeamScore = ((awayTeam.stats.avgPointsScored - homeTeam.stats.avgDefenseAgainstAvgPoints) + (homeTeam.stats.avgPointsAgainst + awayTeam.stats.avgPointsAgainstAvgDefense)) / 2
    
    
    
}

func findAvgPointsAgainstAvgDefense(teamToCalculate: Team) -> Float
{
    var totalMargin : Float = 0
    
    for i in teamToCalculate.games
    {
        totalMargin += (teamToCalculate.stats.avgPointsScored - i.opposingTeam.stats.avgPointsAgainst)
    }
    
    return totalMargin / teamToCalculate.gamesPlayed
    
}

func findAvgDefenseAgainstAvgPointsAgainst(teamToCalculate : Team) -> Float
{
    var totalMargin : Float = 0
    
    for i in teamToCalculate.games
    {
        totalMargin += (i.opposingTeam.stats.avgPointsScored - teamToCalculate.stats.avgPointsAgainst)
    }
    
    return totalMargin / teamToCalculate.gamesPlayed
}






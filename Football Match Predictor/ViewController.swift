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
    
    
    var lsu = Team(name : "LSU", wins : Float(8), losses : Float(4), gamesPlayed : Float(12), pointsScored : Float(340), pointsAgainst : Float(189), avgPointsScored : Float(340/12), avgPointsAgainst : Float(189/12))
    
    
    
    
    
    
    
    

    
    
    
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
    
    
    
    
    bufferTeam.meanPointsScored = teamToCalculate.pointsScored / teamToCalculate.gamesPlayed
    bufferTeam.meanPointsAgainst = teamToCalculate.pointsAgainst / teamToCalculate.gamesPlayed
    
    bufferTeam.pointsScoredStdev = calculateStandardDeviation(numbers: teamToCalculate.scoresFor, mean: bufferTeam.meanPointsScored)
    bufferTeam.pointsAgainstStdev = calculateStandardDeviation(numbers: teamToCalculate.scoresAgainst, mean: bufferTeam.meanPointsAgainst)
    
    
    
    
    return bufferTeam
    
}

func calculateStandardDeviation(numbers : [Float], mean : Float) -> Float
{
    var sum : Float = 0.0
    for number in numbers
    {
        sum += pow((number - mean), 2)
        
        
    }
    
    return sqrt((1/Float(numbers.count))*sum)
    
    
}



func startMatch(homeTeam : Team, awayTeam : Team, isNeutral : Bool) -> Team
{
    var homeTeamScore : Float = 0
    var awayTeamScore : Float = 0
    
    homeTeamScore = ((homeTeam.avgPointsScored - awayTeam.avgDefenseAgainstAvgPoints) + (awayTeam.avgPointsAgainst + homeTeam.avgPointsAgainstAvgDefense)) / 2
    
    awayTeamScore = ((awayTeam.avgPointsScored - homeTeam.avgDefenseAgainstAvgPoints) + (homeTeam.avgPointsAgainst + awayTeam.avgPointsAgainstAvgDefense)) / 2
    
    
    
}

func findAvgPointsAgainstAvgDefense(teamToCalculate: Team) -> Float
{
    var totalMargin : Float = 0
    
    for i in teamToCalculate.games
    {
        totalMargin += (teamToCalculate.avgPointsScored - i.opposingTeam.avgPointsAgainst)
    }
    
    return totalMargin / teamToCalculate.gamesPlayed
    
}

func findAvgDefenseAgainstAvgPointsAgainst(teamToCalculate : Team) -> Float
{
    var totalMargin : Float = 0
    
    for i in teamToCalculate.games
    {
        totalMargin += (i.opposingTeam.avgPointsScored - teamToCalculate.avgPointsAgainst)
    }
    
    return totalMargin / teamToCalculate.gamesPlayed
}






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



//This function performs all of the calculations to obtain the statistical data
func statCalculations(teamToCalculate : Team) -> TeamStats
{
    //This temporarily holds the data that will be returned from the function
    var bufferTeam = TeamStats()
    
    //These are basic calculations that get the average points scored and points allowed
    bufferTeam.avgPointsScored = teamToCalculate.pointsScored / teamToCalculate.gamesPlayed
    bufferTeam.avgPointsAgainst = teamToCalculate.pointsAgainst / teamToCalculate.gamesPlayed
    
    //This stores the average number of points the offense overperfors/underperforms the defense on opposing teams
    bufferTeam.avgPointsAgainstAvgDefense = findAvgPointsAgainstAvgDefense(teamToCalculate: teamToCalculate)
    
    //This stores the average number of points the defense stops/allows the offense on opposing teams
    bufferTeam.avgDefenseAgainstAvgPoints = findAvgDefenseAgainstAvgPointsAgainst(teamToCalculate: teamToCalculate)
    
    //Returning the data
    return bufferTeam
    
}



//This function does the matchup between the two selected teams
func startMatch(homeTeam : Team, awayTeam : Team)
{
    //Scores that will be calculated for each team
    var homeTeamScore : Float = 0
    var awayTeamScore : Float = 0
    
    
    //This performs the calculation to find the home teams' score
    homeTeamScore = ((homeTeam.stats.avgPointsScored - awayTeam.stats.avgDefenseAgainstAvgPoints) + (awayTeam.stats.avgPointsAgainst + homeTeam.stats.avgPointsAgainstAvgDefense)) / 2
    
    //This performs the calculation to find the away teams' score
    awayTeamScore = ((awayTeam.stats.avgPointsScored - homeTeam.stats.avgDefenseAgainstAvgPoints) + (homeTeam.stats.avgPointsAgainst + awayTeam.stats.avgPointsAgainstAvgDefense)) / 2
    
    

}

//This function finds the averate points that a team overperformed/underperformed against other teams average defense
func findAvgPointsAgainstAvgDefense(teamToCalculate: Team) -> Float
{
    //This stores the total margin of overperformance/underperformance
    var totalMargin : Float = 0
    
    //This goes through all of the games played by the team to calculate the margin
    for i in teamToCalculate.games
    {
        //This calculates the difference between the offense of the match and the average defense of the team
        totalMargin += (teamToCalculate.stats.avgPointsScored - i.opposingTeam.stats.avgPointsAgainst)
    }
    
    //Returns the average margin
    return totalMargin / teamToCalculate.gamesPlayed
    
}

//This function finds the average points the defense overperforms/underperforms defending against the opposing teams' average offense
func findAvgDefenseAgainstAvgPointsAgainst(teamToCalculate : Team) -> Float
{
    //This stores the total margin
    var totalMargin : Float = 0
    
    //This goes through all of the games played by the team to calculate the margin
    for i in teamToCalculate.games
    {
        //The difference between the average points scored and the points that the defense allowed in that game
        totalMargin += (i.opposingTeam.stats.avgPointsScored - teamToCalculate.stats.avgPointsAgainst)
    }
    //Returns the average overperformance/underperformance
    return totalMargin / teamToCalculate.gamesPlayed
}






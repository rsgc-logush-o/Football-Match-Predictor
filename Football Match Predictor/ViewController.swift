//
//  ViewController.swift
//  Football Match Predictor
//
//  Created by Student on 2017-02-28.
//  Copyright © 2017 Student. All rights reserved.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    // MARK: Properties
    
    
    //This holds all of the matches from the season
    var allMatches : [Match] = []
    
    //This stores all of the teams, it is a dictionary so the team's ID will reveal the team
    var teams = [Int : Team]()
    
    

    
    // MARK: viewDidLoad
    // Runs once
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let scene = TitlePage(size: CGSize(width: 800, height: 600))
        
     //   let skView = SKView(frame: NSRect())

        // Do any additional setup after loading the view.
        
        getTeamJSON()
        getScheduleJSON()
        print("meme")
       
    }
    
    // MARK: Other functions

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func getTeamJSON()
    {
        //This is the adress to access the teams' data
        let adress : String = "https://api.fantasydata.net/v3/cfb/scores/JSON/TeamSeasonStats/2016"
        
        //let adress : String = "http://mail.rsgc.on.ca/~ologush/teamdata.json"

        
        //Checking if this is a legitimate url
        if let url = URL(string: adress)
        {
            print(url)
            
            //Creating the url request
           var urlRequest = URLRequest(url : url)
            //adding the api key
            urlRequest.addValue("aacad0e238134cd180db37269fb8e684", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            
            //setting the configuration to default
            let config = URLSessionConfiguration.default
            
            let session = URLSession(configuration : config)
            
            //beginning the session to collect data
            let task = session.dataTask(with: urlRequest)
            {
                
                (data, response, error)in
                
                if let r = response as? HTTPURLResponse {
                    
                    // If the request was successful, parse the given data
                    if r.statusCode == 200 {
                        
                        if let d = data {
                            
                            // Parse the retrieved data
                            self.parseTeamJSON(d)
                            
                        }
                        
                    }
                    
                }
                
            }
            
            //Resumes the rest of the code if task is not successful
            task.resume()
            //if the url is not valid this will happen
        } else {
            print("Error cannot create URL object")
        }
        
        
    }
    
    //This parses the teams' JSON data
    func parseTeamJSON(_ theData : Data)
    {
        print("-------------THIS IS THE DATA--------------")
        
        do{
            let allTeams = try JSONSerialization.jsonObject(with: theData, options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
            
            //Iterating through all of the teams
            for eachTeam in allTeams
            {
                //creating a dictionary for the data to be accessed from
                if let thisTeam = eachTeam as? [String: AnyObject]
                {
                    //Stores the needed data using let statements
                    guard let teamID : Int = thisTeam["TeamID"] as? Int,
                       // let key : Int = thisTeam["Key"] as? Int,
                        let school : String = thisTeam["Team"] as? String,
                        let team : String = thisTeam["Name"] as? String,
                        let wins : Float = thisTeam["Wins"] as? Float,
                        let losses : Float = thisTeam["Losses"] as? Float,
                        let pointsFor : Float = thisTeam["PointsFor"] as? Float,
                        let pointsAgainst : Float = thisTeam["PointsAgainst"] as? Float,
                        let gamesPlayed : Float = thisTeam["Games"] as? Float
                    else
                    {
                        print("Can't get data")
                        return
                    }
                    
                    //This buffer team stores all of the team data
                    let bufferTeam = Team(name: team, wins: wins, losses: losses, gamesPlayed: gamesPlayed, pointsScored: pointsFor, pointsAgainst: pointsAgainst, teamID: teamID, stats: TeamStats(avgPointsScored: pointsFor/gamesPlayed, avgPointsAgainst: pointsAgainst/gamesPlayed, avgPointsAgainstAvgDefense: 0, avgDefenseAgainstAvgPoints: 0))
                    
                    //creates a location in the dictionary for the team using the teamID
                    teams[teamID] = bufferTeam
                    
                    //Prints all of the data obtained
                    print(school)
                    print(team)
                    print(teamID)
                    print(wins)
                    print(losses)
                    print(pointsFor)
                    print(pointsAgainst)
                    print(gamesPlayed)
                    
                }
            }
        }catch let error as NSError {//if it fails and there is an error
            
            print ("Failed to load: \(error.localizedDescription)")
            
        }
        
    }
    
    //This gets the JSON data for the schedule
    func getScheduleJSON()
    {
        //This is the adress to access the data
        let adress : String = "https://api.fantasydata.net/v3/cfb/scores/JSON/Games/2016"
        
        //creates url from string
        if let url = URL(string: adress)
        {
            print(url)
            
            //creates the url request
            var urlRequest = URLRequest(url : url)
            //adds the api key to the url request
            urlRequest.addValue("aacad0e238134cd180db37269fb8e684", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            
            //setting the default configuration
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration : config)
            
            //This gets the data
            let task = session.dataTask(with: urlRequest)
            {
                (data, response, error)in
                
                if let r = response as? HTTPURLResponse {
                    
                    // If the request was successful, parse the given data
                    if r.statusCode == 200 {
                        
                        if let d = data {
                            
                            // Parse the retrieved data
                            self.parseScheduleJSON(d)
                            
                        }
                        
                    }
                    
                }
                
            }
            
            task.resume()
            
        } else {
            print("Error cannot create URL object")
        }
        
        
    }
    
    //This parses the JSON for the schedule
    func parseScheduleJSON(_ theData : Data)
    {
        do{
            
            let allGames = try JSONSerialization.jsonObject(with: theData, options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
            
            //Iterates through each game in the schedule
            for eachGame in allGames
            {
                //Casts into a dictionary to access the data
                if let thisGame = eachGame as? [String : AnyObject]
                {
                    //uses let statements to store the data
                    guard let gameID : Int = thisGame["GameID"] as? Int,
                        let homeTeam : String = thisGame["HomeTeam"] as? String,
                        let awayTeam : String = thisGame["AwayTeam"] as? String,
                        let homeTeamID : Int = thisGame["HomeTeamID"] as? Int,
                        let awayTeamID : Int = thisGame["AwayTeamID"] as? Int,
                        let status : String = thisGame["Status"] as? String
                        
                        
                        
                        else {//If the data cannot be cast to these datatypes
                            print("Can't get data")
                            return
                    }
                    if status == "Final"
                    {
                        let homeTeamScore : Int = (thisGame["HomeTeamScore"] as? Int)!
                        let awayTeamScore : Int = (thisGame["AwayTeamScore"] as? Int)!
                    

                    
                    print(gameID)
                    print(homeTeam)
                    print(awayTeam)
                    print(homeTeamID)
                    print(awayTeamID)
                    print(homeTeamScore)
                    print(awayTeamScore)
                    //Temporarily hold the match data together in this buffer
                  
                    
                    let matchBuffer = Match(homeTeamID: homeTeamID, awayTeamID: awayTeamID, homeTeamScore: Float(homeTeamScore), awayTeamScore: Float(awayTeamScore), gameID: gameID)
                         allMatches.append(matchBuffer)
                    }
                    
                    //This adds the buffer to all of the matches
                   
                    
                }
            }
        }catch let error as NSError {
            
            print ("Failed to load: \(error.localizedDescription)")
            
        }
         sortMatches()
        
    }
    
    func sortMatches()
    {
        print("meme")
        for (i, k) in teams
        {
            var totalDefenseMargin : Float = 0
            var totalOffenseMargin : Float = 0
            
           
            
            if let teamToCalculate = teams[i]
            {
                for j in allMatches
                {
                    if j.homeTeamID == teamToCalculate.teamID
                    {
                        totalOffenseMargin += (j.homeTeamScore - (teams[j.awayTeamID]?.stats.avgPointsAgainst)!)
                        totalDefenseMargin += (j.awayTeamScore - (teams[j.awayTeamID]?.stats.avgPointsScored)!)
                    }else if j.awayTeamID == teamToCalculate.teamID
                    {
                        totalOffenseMargin += (j.awayTeamScore - (teams[j.homeTeamID]?.stats.avgPointsAgainst)!)
                        totalDefenseMargin += (j.homeTeamScore - (teams[j.homeTeamID]?.stats.avgPointsScored)!)
                    }
                }
            }
            
            teams[i]?.stats.avgPointsAgainstAvgDefense = totalOffenseMargin/(teams[i]?.gamesPlayed)!
            teams[i]?.stats.avgDefenseAgainstAvgPoints = totalDefenseMargin/(teams[i]?.gamesPlayed)!
            
            print(teams[i]?.stats.avgPointsAgainstAvgDefense)
            
        }
    }
    
    func predictMatch(team1 : Team, team2 : Team)
    {
        var team1Score : Float = 0
        var team2Score : Float = 0
        
        team1Score = ((team1.stats.avgPointsScored - team2.stats.avgDefenseAgainstAvgPoints) + (team2.stats.avgPointsAgainst + team1.stats.avgPointsAgainstAvgDefense)) / 2
        
        team2Score = ((team2.stats.avgPointsScored - team1.stats.avgDefenseAgainstAvgPoints) + (team1.stats.avgPointsAgainst + team2.stats.avgPointsAgainstAvgDefense)) / 2

    }


}



//This function performs all of the calculations to obtain the statistical data
//func statCalculations(teamToCalculate : Team) -> TeamStats
//{
//    //This temporarily holds the data that will be returned from the function
//    var bufferTeam = TeamStats()
//    
//    //These are basic calculations that get the average points scored and points allowed
//    bufferTeam.avgPointsScored = teamToCalculate.pointsScored / teamToCalculate.gamesPlayed
//    bufferTeam.avgPointsAgainst = teamToCalculate.pointsAgainst / teamToCalculate.gamesPlayed
//    
//    //This stores the average number of points the offense overperfors/underperforms the defense on opposing teams
//    bufferTeam.avgPointsAgainstAvgDefense = findAvgPointsAgainstAvgDefense(teamToCalculate: teamToCalculate)
//    
//    //This stores the average number of points the defense stops/allows the offense on opposing teams
//    bufferTeam.avgDefenseAgainstAvgPoints = findAvgDefenseAgainstAvgPointsAgainst(teamToCalculate: teamToCalculate)
//    
//    //Returning the data
//    return bufferTeam
//    
//}
//
//
//
////This function does the matchup between the two selected teams
//func startMatch(homeTeam : Team, awayTeam : Team)
//{
//    //Scores that will be calculated for each team
//    var homeTeamScore : Float = 0
//    var awayTeamScore : Float = 0
//    
//    
//    //This performs the calculation to find the home teams' score
//    homeTeamScore = ((homeTeam.stats.avgPointsScored - awayTeam.stats.avgDefenseAgainstAvgPoints) + (awayTeam.stats.avgPointsAgainst + homeTeam.stats.avgPointsAgainstAvgDefense)) / 2
//    
//    //This performs the calculation to find the away teams' score
//    awayTeamScore = ((awayTeam.stats.avgPointsScored - homeTeam.stats.avgDefenseAgainstAvgPoints) + (homeTeam.stats.avgPointsAgainst + awayTeam.stats.avgPointsAgainstAvgDefense)) / 2
//    
//    
//
//}
//
////This function finds the averate points that a team overperformed/underperformed against other teams average defense
//func findAvgPointsAgainstAvgDefense(teamToCalculate: Team) -> Float
//{
//    //This stores the total margin of overperformance/underperformance
//    var totalMargin : Float = 0
//    
//    //This goes through all of the games played by the team to calculate the margin
//    for i in teamToCalculate.games
//    {
//        //This calculates the difference between the offense of the match and the average defense of the team
//        totalMargin += (teamToCalculate.stats.avgPointsScored - i.opposingTeam.stats.avgPointsAgainst)
//    }
//    
//    //Returns the average margin
//    return totalMargin / teamToCalculate.gamesPlayed
//    
//}
//
////This function finds the average points the defense overperforms/underperforms defending against the opposing teams' average offense
//func findAvgDefenseAgainstAvgPointsAgainst(teamToCalculate : Team) -> Float
//{
//    //This stores the total margin
//    var totalMargin : Float = 0
//    
//    //This goes through all of the games played by the team to calculate the margin
//    for i in teamToCalculate.games
//    {
//        //The difference between the average points scored and the points that the defense allowed in that game
//        totalMargin += (i.opposingTeam.stats.avgPointsScored - teamToCalculate.stats.avgPointsAgainst)
//    }
//    //Returns the average overperformance/underperformance
//    return totalMargin / teamToCalculate.gamesPlayed
//}






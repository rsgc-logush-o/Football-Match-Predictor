//: Playground - noun: a place where people can play

import Cocoa




struct Match
{
    //Stores the hometeam's ID
    var homeTeamID : Int
    
    //Stores the awayteam's ID
    var awayTeamID : Int
    
    //Stores the scores
    var homeTeamScore : Float
    var awayTeamScore : Float
    
    //Stores the gameID
    var gameID : Int
}

struct TeamStats
{
    //The average points scored and average points allowed
    var avgPointsScored : Float = 0
    var avgPointsAgainst : Float = 0
    
    //These store the average overperformance/underperformance by the teams offense/defense
    var avgPointsAgainstAvgDefense : Float = 0
    var avgDefenseAgainstAvgPoints : Float = 0
    
}


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
    
    
    //This stores the teams statistics in another structure
    var stats : TeamStats
    
}

//This holds all of the matches from the season
var allMatches : [Match] = []

//This stores all of the teams, it is a dictionary so the team's ID will reveal the team
var teams = [Int : Team]()

//This gets all of the teams' data
func getTeamJSON()
{
    //This is the adress to access the teams' data
    let adress : String = "https://api.fantasydata.net/v3/cfb/scores/JSON/Games/2016"
    
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
                        parseTeamJSON(d)
                        
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
            if let thisTeam = eachTeam as? [String : AnyObject]
            {
                //Stores the needed data using let statements
                guard let teamID : Int = thisTeam["TeamID"] as? Int,
                    let key : Int = thisTeam["Key"] as? Int,
                    let school : String = thisTeam["School"] as? String,
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
                let bufferTeam = Team(name: team, wins: wins, losses: losses, gamesPlayed: gamesPlayed, pointsScored: pointsFor, pointsAgainst: pointsAgainst, stats: TeamStats(avgPointsScored: pointsFor/gamesPlayed, avgPointsAgainst: pointsAgainst/gamesPlayed, avgPointsAgainstAvgDefense: 0, avgDefenseAgainstAvgPoints: 0))
                
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
                        parseScheduleJSON(d)
                        
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
                let homeTeamScore : Float = thisGame["HomeTeamScore"] as? Float,
                let awayTeamScore : Float = thisGame["AwayTeamscore"] as? Float
                
                
                
                    else {//If the data cannot be cast to these datatypes
                    print("Can't get data")
                        return
                }
                
                //Temporarily hold the match data together in this buffer
                let matchBuffer = Match(homeTeamID: homeTeamID, awayTeamID: awayTeamID, homeTeamScore: homeTeamScore, awayTeamScore: awayTeamScore, gameID: gameID)
                
                //This adds the buffer to all of the matches
                allMatches.append(matchBuffer)
                
            }
        }
    }catch let error as NSError {
        
        print ("Failed to load: \(error.localizedDescription)")
        
    }

}


//Testing to get the team JSON
getTeamJSON()




//: Playground - noun: a place where people can play

import Cocoa




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
    
    //This array stores all of the matches played by this team
    
    //This stores the teams statistics in another structure
    var stats : TeamStats
    
}


var allMatches : [Match] = []

var teams = [Int : Team]()

func getTeamJSON()
{
    let adress : String = "https://api.fantasydata.net/v3/cfb/scores/JSON/Games/2016"
    
    if let url = URL(string: adress)
    {
        print(url)
        
        let urlRequest = URLRequest(url : url)
        urlRequest.addValue("aacad0e238134cd180db37269fb8e684", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration : config)
      
        
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
        
        task.resume()
        
    } else {
        print("Error cannot create URL object")
    }
    
    
}

func parseTeamJSON(_ theData : Data)
{
    print("-------------THIS IS THE DATA--------------")
    
    do{
        let allTeams = try JSONSerialization.jsonObject(with: theData, options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
        
        for eachTeam in allTeams
        {
            if let thisTeam = eachTeam as? [String : AnyObject]
            {
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
                
                let bufferTeam = Team(name: team, wins: wins, losses: losses, gamesPlayed: gamesPlayed, pointsScored: pointsFor, pointsAgainst: pointsAgainst, stats: TeamStats(avgPointsScored: pointsFor/gamesPlayed, avgPointsAgainst: pointsAgainst/gamesPlayed, avgPointsAgainstAvgDefense: 0, avgDefenseAgainstAvgPoints: 0))
                
                teams[teamID] = bufferTeam
                
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
    }catch let error as NSError {
        
        print ("Failed to load: \(error.localizedDescription)")
        
    }

}

func getScheduleJSON()
{
    let adress : String = "https://api.fantasydata.net/v3/cfb/scores/JSON/Games/2016"
    
    if let url = URL(string: adress)
    {
        print(url)
        
        var urlRequest = URLRequest(url : url)
         urlRequest.addValue("aacad0e238134cd180db37269fb8e684", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration : config)
        
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

func parseScheduleJSON(_ theData : Data)
{
    do{
        let allGames = try JSONSerialization.jsonObject(with: theData, options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
        
        for eachGame in allGames
        {
            if let thisGame = eachGame as? [String : AnyObject]
            {
                guard let gameID : Int = thisGame["GameID"] as? Int,
              let homeTeam : String = thisGame["HomeTeam"] as? String,
               let awayTeam : String = thisGame["AwayTeam"] as? String,
                let homeTeamID : Int = thisGame["HomeTeamID"] as? Int,
                let awayTeamID : Int = thisGame["AwayTeamID"] as? Int,
                let homeTeamScore : Float = thisGame["HomeTeamScore"] as? Float,
                let awayTeamScore : Float = thisGame["AwayTeamscore"] as? Float
                
                
                
                    else {
                    print("Can't get data")
                        return
                }
                
                let matchBuffer = Match(homeTeamID: homeTeamID, awayTeamID: awayTeamID, homeTeamScore: homeTeamScore, awayTeamScore: awayTeamScore, gameID: gameID)
                
                allMatches.append(matchBuffer)
                
            }
        }
    }catch let error as NSError {
        
        print ("Failed to load: \(error.localizedDescription)")
        
    }

}



getTeamJSON()




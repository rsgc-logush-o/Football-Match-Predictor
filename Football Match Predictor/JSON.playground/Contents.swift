//: Playground - noun: a place where people can play

import Cocoa

func getTeamJSON()
{
    let adress : String = "insert string"
    
    if let url = URL(string: adress)
    {
        print(url)
        
        let urlRequest = URLRequest(url : url)
        
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
                
            }
        }
    }catch let error as NSError {
        
        print ("Failed to load: \(error.localizedDescription)")
        
    }

}

func getScheduleJSON()
{
    let adress : String = "insert string"
    
    if let url = URL(string: adress)
    {
        print(url)
        
        let urlRequest = URLRequest(url : url)
        
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
                
            }
        }
    }catch let error as NSError {
        
        print ("Failed to load: \(error.localizedDescription)")
        
    }

}

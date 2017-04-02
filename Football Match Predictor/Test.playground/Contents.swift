

import Cocoa
import Foundation




struct Match
{
    var opposingTeam : Team
    
    var yourScore : Float
    var opposingScore : Float
}

struct Team
{
    var name = ""
    var wins : Float = 0
    var losses : Float = 0
    var gamesPlayed : Float = 0
    
    var pointsScored : Float = 0
    var pointsAgainst : Float = 0
    
    var games : [Match] = []
    
    var stats : TeamStats
    
}

struct TeamStats
{
    var avgPointsScored : Float = 0
    var avgPointsAgainst : Float = 0
    
    var avgPointsAgainstAvgDefense : Float = 0
    var avgDefenseAgainstAvgPoints : Float = 0
    
}

var lsu : Team

lsu = Team()

lsu.name = "LSU"
lsu.wins = 8
lsu.losses = 4
lsu.gamesPlayed = 12
lsu.pointsScored = 340
lsu.pointsAgainst = 189


var louisville : Team



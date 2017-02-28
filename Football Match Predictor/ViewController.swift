//
//  ViewController.swift
//  Football Match Predictor
//
//  Created by Student on 2017-02-28.
//  Copyright © 2017 Student. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

struct team
{
    var name = ""
    var wins = 0
    var losses = 0
    var ties = 0
    var gamesPlayed = 0
    
    var pointsScored = 0
    var pointsAgainst = 0
    
    
}

struct teamStats
{
    var meanPointsScored = 0
    var meanPointsAgainst = 0
    var medianPointsScored = 0
    var medianPointsAgainst = 0
    
    var pointsScoredStdev = 0
    var pointsAgainstStdev = 0
    
    
}

struct match
{
    var yourPoints = 0
    var theirPoints = 0
    
    var isHome = 0
    var result = 0
    
    
}

//
//  ScoreVC.swift
//  BrainTeaser
//
//  Created by Gene McCullagh on 4/3/16.
//  Copyright © 2016 Gene McCullagh. All rights reserved.
//

import UIKit

class ScoreVC: UIViewController {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var totalGuess = correctScore + wrongScore
    
    
    

    override func viewDidLoad() {
        summaryLabel.text = "You guessed \(totalGuess) times in \(GAME_TIMER) seconds!"
        rightLabel.text = "\(correctScore)"
        wrongLabel.text = "\(wrongScore)"
        if correctScore > wrongScore {
            messageLabel.text = "GREAT JOB!"
        } else {
            messageLabel.text = "Better Luck Next Time!"
        }
        super.viewDidLoad()

        
    }

    @IBAction func replayPressed(sender: AnyObject) {
        correctScore = 0
        wrongScore = 0
        performSegueWithIdentifier("ReplaySeque", sender: self)
    }
}

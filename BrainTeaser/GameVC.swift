//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Gene McCullagh on 3/27/16.
//  Copyright © 2016 Gene McCullagh. All rights reserved.
//

import UIKit
import pop

var correctScore = 0
var wrongScore = 0

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    var currentCard: Card!
    var previousCard: Card?
    var counter = GAME_TIMER
    var timer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        timerLabel.text = "\(counter)"
        wrongLabel.text = "\(wrongScore)"
        rightLabel.text = "\(correctScore)"
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        previousCard = nil
        self.view.addSubview(currentCard)
        
        print("VIEW DID LOAD\nPrevious Card: \(previousCard?.currentShape)\nCurrent Card: \(currentCard!.currentShape)\n")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        AnimationEngine.animateToPosition(currentCard, position: AnimationEngine.screenCenterPosition) { (anim:POPAnimation!, finished: Bool) in
        }
    }
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer("Y")
        } else {
            titleLbl.text = "Does this card\nmatch the previous card?"
            cdTimer()
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(sender: AnyObject) {
        checkAnswer("N")
        showNextCard()
    }
    
    func showNextCard() {
        if let current = currentCard {
            let cardToRemove = current
            previousCard = currentCard
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool)  in
            })
        }
    }
    
    func createCardFromNib() -> Card! {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    func checkAnswer(myAnswer: String) {
        if currentCard.currentShape == previousCard?.currentShape && myAnswer == "Y" {
            correctScore += 1
            rightLabel.text = "\(correctScore)"
        } else if myAnswer == "Y" {
            wrongScore += 1
            wrongLabel.text = "\(wrongScore)"
        }
        
        if currentCard.currentShape != previousCard?.currentShape && myAnswer == "N" {
            correctScore += 1
            rightLabel.text = "\(correctScore)"
        } else if myAnswer == "N" {
            wrongScore += 1
            wrongLabel.text = "\(wrongScore)"
        }
    }

    func cdTimer() {
        timerLabel.hidden = false
        fireTimer()
        counter = GAME_TIMER
    }
    
    func fireTimer()  {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameVC.UpdateTimer), userInfo: nil, repeats: true)
    }
    
    func UpdateTimer()  {
        if counter > 0 {
            timerLabel.text = "\(counter)"
            counter -= 1
        } else {
            timer.invalidate()
            timerLabel.text = "GAME OVER"
            
            performSegueWithIdentifier("ScoreSegue", sender: self)
            
        }
    }
}

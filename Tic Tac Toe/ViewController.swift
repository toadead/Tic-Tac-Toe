//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Yu Andrew - andryu on 12/25/14.
//  Copyright (c) 2014 Andrew Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var moves = 0
    var image: UIImage?
    var hasAWinner = false
    var winningButtonTagsCombo = [
        [1,2,3],
        [1,4,7],
        [1,5,9],
        [2,5,8],
        [3,6,9],
        [3,5,7],
        [4,5,6],
        [7,8,9]
    ]
    
    @IBOutlet var allSpots: [UIButton]!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBAction func madeAMove(sender: AnyObject) {
        var button = sender as UIButton
        // prevent players from making moves on already played spots
        if (button.imageForState(.Normal) == nil) {
            let image = UIImage(named: decideCircleOrCrossImage())
            button.setImage(image, forState: .Normal)
            determineWinner(decideCircleOrCrossImage())
            moves++
        }
    }
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        moves = 0
        image = nil
        hasAWinner = false
        for button in allSpots {
            button.setImage(nil, forState: .Normal)
            button.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasAWinner {
            moveWinningMsgOutOfWay()
        }
    }

    // ===========================================================================
    // helper functions
    // ===========================================================================
    func decideCircleOrCrossImage() -> String {
        // "circle" moves first, then "cross" moves
        return self.moves % 2 == 0 ?  "circle.png" : "cross.png"
    }
    
    func determineWinner(imageName: String) {
        for winningButtonTags in winningButtonTagsCombo {
            let firstImage = (self.view.viewWithTag(winningButtonTags[0]) as UIButton).imageForState(.Normal)
            let secondImage = (self.view.viewWithTag(winningButtonTags[1]) as UIButton).imageForState(.Normal)
            let thirdImage = (self.view.viewWithTag(winningButtonTags[2]) as UIButton).imageForState(.Normal)
            if (firstImage == secondImage &&
                secondImage == thirdImage &&
                thirdImage != nil) {
                winnerLabel.text = imageName.componentsSeparatedByString(".")[0] + " is the winner!"
                endGame()
                break
            }
        }
        if !hasAWinner && moves == 8 {
            winnerLabel.text = "The game is a tie. Play another one"
            endGame()
        }
    }
    
    func endGame() {
        for button in allSpots {
            button.enabled = false
        }
        UIView.animateWithDuration(0.5, animations: {
            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
            self.playAgainButton.alpha = 1
        })
        hasAWinner = true
    }
    
    func moveWinningMsgOutOfWay() {
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.alpha = 0
    }

}


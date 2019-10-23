//
//  ScoreBoardTableViewCell.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class ScoreBoardTableViewCell: UITableViewCell {
    
    var score: Score? {
        didSet {
            setUpViews()
        }
    }
    
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    @IBOutlet weak var scoreForPlayerOne: UILabel!
    @IBOutlet weak var scoreForPlayerTwo: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setUpViews() {
        playerOneLabel.text = PlayerController.shared.players[0].name
        playerTwoLabel.text = PlayerController.shared.players[1].name
        
        scoreForPlayerOne.text = "\(ScoreController.sharedScore.scores[0].score)"
        scoreForPlayerTwo.text = "\(ScoreController.sharedScore.scores[1].score)"
        
        timeLabel.text = ScoreController.sharedScore.scores[0].timestamp.timeAsString()
        dateLabel.text = ScoreController.sharedScore.scores[0].timestamp.dateAsString()
    }
}

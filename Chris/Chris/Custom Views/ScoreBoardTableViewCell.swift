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
        didSet{
            updateForNightMode()
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
    
    func updateForNightMode() {
        if PlayerController.shared.nightMode {
            self.backgroundColor = .darkerGray
            self.playerOneLabel.textColor = .white
            self.playerTwoLabel.textColor = .white
            self.scoreForPlayerOne.textColor = .white
            self.scoreForPlayerTwo.textColor = .white
            self.timeLabel.textColor = .white
            self.dateLabel.textColor = .white
        } else {
            self.backgroundColor = .white
            self.playerOneLabel.textColor = .black
            self.playerTwoLabel.textColor = .black
            self.scoreForPlayerOne.textColor = .black
            self.scoreForPlayerTwo.textColor = .black
            self.timeLabel.textColor = .black
            self.dateLabel.textColor = .black
        }
    }
    
    func setUpViews() {
        guard let score = score else { return }
        playerOneLabel.text = score.playerOne.name
        playerTwoLabel.text = score.playerTwo.name
        
        scoreForPlayerOne.text = "\(score.playerOneScore)"
        scoreForPlayerTwo.text = "\(score.playerTwoScore)"
        
        timeLabel.text = score.timestamp.timeAsString()
        dateLabel.text = score.timestamp.dateAsString()
    }
}

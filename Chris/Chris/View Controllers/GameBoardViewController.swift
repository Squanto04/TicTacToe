//
//  GameBoardViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    // MARK: - Properties
    var ActivePlayer = Int.random(in: 1 ..< 3)
    var GameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let WinningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    var GameIsActive = true
    var playerOneTurn: UIImage!
    var playerTwoTurn: UIImage!

    // MARK: - Outlets
    // Labels
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerWonLabel: UILabel!
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    // Image Views
    @IBOutlet weak var gameBoardImageView: UIImageView!
    @IBOutlet weak var turnPickerImageView: UIImageView!
    // Buttons
    @IBOutlet weak var newPlayersButton: TicTacToeButton!
    @IBOutlet weak var endGameButton: TicTacToeButton!
    @IBOutlet weak var playerAgainButton: TicTacToeButton!
    // Game Buttons
    @IBOutlet weak var gameButtonOne: UIButton!
    @IBOutlet weak var gameButtonTwo: UIButton!
    @IBOutlet weak var gameButtonThree: UIButton!
    @IBOutlet weak var gameButtonFour: UIButton!
    @IBOutlet weak var gameButtonFive: UIButton!
    @IBOutlet weak var gameButtonSix: UIButton!
    @IBOutlet weak var gameButtonSeven: UIButton!
    @IBOutlet weak var gameButtonEight: UIButton!
    @IBOutlet weak var gameButtonNine: UIButton!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func gameButtonTapped(_ sender: AnyObject) {
    }
    
    @IBAction func newPlayersButtonTapped(_ sender: Any) {
    }
    
    @IBAction func endGameButtonTapped(_ sender: Any) {
    }
    
    @IBAction func playAgainButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        playerOneLabel.text = PlayerController.shared.players[0].name
        playerTwoLabel.text = PlayerController.shared.players[1].name
        
        if PlayerController.shared.nightMode == false {
            self.view.backgroundColor = .white
            self.gameBoardImageView.image = UIImage(named: "boardBlack")
            self.playerOneTurn = UIImage(named: "LeftArrow")
            self.playerTwoTurn = UIImage(named: "RightArrow")
            self.playerOneLabel.textColor = .black
            self.playerOneScore.textColor = .black
            self.playerTwoLabel.textColor = .black
            self.playerTwoScore.textColor = .black
            self.playerWonLabel.textColor = .black
        } else {
            self.view.backgroundColor = .black
            self.gameBoardImageView.image = UIImage(named: "boardWhite")
            self.playerOneTurn = UIImage(named: "LeftWhiteArrow")
            self.playerTwoTurn = UIImage(named: "RightWhiteArrow")
            self.playerOneLabel.textColor = .white
            self.playerOneScore.textColor = .white
            self.playerTwoLabel.textColor = .white
            self.playerTwoScore.textColor = .white
            self.playerWonLabel.textColor = .white
        }
    }
    
}

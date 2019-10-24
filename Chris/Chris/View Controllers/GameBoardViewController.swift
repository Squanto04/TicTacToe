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
    var activePlayer = Int.random(in: 1 ..< 3)
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    var gameIsActive = true
    var playerOneTurn: UIImage!
    var playerTwoTurn: UIImage!
    var playerOneTempScore = 0
    var playerTwoTempScore = 0
    
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
    @IBOutlet weak var playAgainButton: TicTacToeButton!
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
        updateViews()
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func gameButtonTapped(_ sender: AnyObject) {
        if gameState[sender.tag - 1] == 0 && gameIsActive == true {
            gameState[sender.tag - 1] = activePlayer
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "cross.png"), for: .normal)
                activePlayer = 2
                turnPickerImageView.image = playerTwoTurn
            } else {
                sender.setImage(UIImage(named: "circle.png"), for: .normal)
                activePlayer = 1
                turnPickerImageView.image = playerOneTurn
            }
        }
        
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                gameIsActive = false
                if gameState[combination[0]] == 1 {
                    playerWonLabel.text = "\(PlayerController.shared.players[0].name) has Won!"
                    playerOneTempScore += 1
                    playerOneScore.text = String(playerOneTempScore)
                } else {
                    playerWonLabel.text = "\(PlayerController.shared.players[1].name) has Won!"
                    playerTwoTempScore += 1
                    playerTwoScore.text = String(playerTwoTempScore)
                }
                
                playAgainButton.isHidden = false
                playerWonLabel.isHidden = false
                newPlayersButton.isHidden = false
                endGameButton.isHidden = true
                self.disableGameButtons()
            }
        }
        
        var count = 1
        if gameIsActive == true {
            for i in gameState {
                count = i*count
            }
            if count != 0 {
                playerWonLabel.text = "It was a draw!"
                playAgainButton.isHidden = false
                playerWonLabel.isHidden = false
                newPlayersButton.isHidden = false
                endGameButton.isHidden = true
            }
        }
    }
    
    @IBAction func newPlayersButtonTapped(_ sender: Any) {
        addPlayersScore()
        resetBoard()
        PlayerController.shared.players = []
        self.dismiss(animated: true)
    }
    
    @IBAction func endGameButtonTapped(_ sender: Any) {
        addPlayersScore()
        PlayerController.shared.players = []
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        resetBoard()
        gameIsActive = true
        
        if activePlayer == 1 {
            self.turnPickerImageView.image = playerOneTurn
        } else {
            self.turnPickerImageView.image = playerTwoTurn
        }
    }
    
    // MARK: - Helper Functions
    func resetBoard() {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        activePlayer = Int.random(in: 1..<3)
        playAgainButton.isHidden = true
        playerWonLabel.isHidden = true
        newPlayersButton.isHidden = true
        endGameButton.isHidden = false
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
        }
        enableGameButtons()
    }
    
    func addPlayersScore() {
        guard let playerOneScore = Int(playerOneScore.text!),
            let playerTwoScore = Int(playerTwoScore.text!)
            else { return }
        let playerOne = PlayerController.shared.players[0]
        let playerTwo = PlayerController.shared.players[1]
        ScoreController.sharedScore.setScore(playerOneScore: playerOneScore, playerTwoScore: playerTwoScore, playerOne: playerOne, playerTwo: playerTwo)
    }
    
    func disableGameButtons() {
        gameButtonOne.isEnabled = false
        gameButtonTwo.isEnabled = false
        gameButtonThree.isEnabled = false
        gameButtonFour.isEnabled = false
        gameButtonFive.isEnabled = false
        gameButtonSix.isEnabled = false
        gameButtonSeven.isEnabled = false
        gameButtonEight.isEnabled = false
        gameButtonNine.isEnabled = false
    }
    
    func enableGameButtons() {
        gameButtonOne.isEnabled = true
        gameButtonTwo.isEnabled = true
        gameButtonThree.isEnabled = true
        gameButtonFour.isEnabled = true
        gameButtonFive.isEnabled = true
        gameButtonSix.isEnabled = true
        gameButtonSeven.isEnabled = true
        gameButtonEight.isEnabled = true
        gameButtonNine.isEnabled = true
    }
    
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
            
            if activePlayer == 1 {
                self.turnPickerImageView.image = playerOneTurn
            } else {
                self.turnPickerImageView.image = playerTwoTurn
            }
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
            
            if activePlayer == 1 {
                self.turnPickerImageView.image = playerOneTurn
            } else {
                self.turnPickerImageView.image = playerTwoTurn
            }
        }
    }
    
}

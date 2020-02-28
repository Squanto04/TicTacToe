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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return PlayerController.shared.current
    }
    
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
    // Constraints
    @IBOutlet weak var gameBoardConstraint: NSLayoutConstraint!
    // Views
    @IBOutlet weak var playerOneView: UIView!
    @IBOutlet weak var playerTwoView: UIView!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setNeedsStatusBarAppearanceUpdate()
        newPlayersButton.layer.cornerRadius = newPlayersButton.frame.height / 6
        playAgainButton.layer.cornerRadius = playAgainButton.frame.height / 6
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
                
                UIView.animate(withDuration: 0.3) {
                    self.playAgainButton.isHidden = false
                    self.playerWonLabel.isHidden = false
                    self.newPlayersButton.isHidden = false
                }
                endGameButton.isHidden = true
                disableGameButtons()
            }
        }
        var count = 1
        if gameIsActive == true {
            for i in gameState {
                count = i*count
            }
            if count != 0 {
                playerWonLabel.text = "It was a draw!"
                UIView.animate(withDuration: 0.3) {
                    self.playAgainButton.isHidden = false
                    self.playerWonLabel.isHidden = false
                    self.newPlayersButton.isHidden = false
                }
                endGameButton.isHidden = true
            }
        }
    }
    
    @IBAction func newPlayersButtonTapped(_ sender: Any) {
        print("New Players Button Tapped")
        addPlayersScore()
        resetBoard()
        PlayerController.shared.players = []
        self.dismiss(animated: true)
    }
    
    @IBAction func endGameButtonTapped(_ sender: Any) {
        print("End Game Button Tapped")
        addPlayersScore()
        PlayerController.shared.players = []
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        print("Play Again Button Tapped")
        resetBoard()
        gameIsActive = true
        
        if activePlayer == 1 {
            self.turnPickerImageView.image = playerOneTurn
        } else {
            self.turnPickerImageView.image = playerTwoTurn
        }
    }
    
    // MARK: - Helper Functions
    func setupViews() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            return
        }
        newPlayersButton.isHidden = true
        playAgainButton.isHidden = true
        
        playerOneLabel.sizeToFit()
        playerTwoLabel.sizeToFit()
        
        switch UIDevice().type {
        case .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPadAir, .iPadAir2, .iPadAir3, .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5, .iPadPro11, .iPadPro9_7, .iPadPro10_5, .iPadPro12_9, .iPadPro2_12_9, .iPadPro3_12_9:
            gameBoardConstraint.constant = -150
            playerOneLabel.font = UIFont.systemFont(ofSize: 30.0, weight: .semibold)
            playerOneScore.font = UIFont.boldSystemFont(ofSize: 40.0)
            playerTwoLabel.font = UIFont.systemFont(ofSize: 30.0, weight: .semibold)
            playerTwoScore.font = UIFont.boldSystemFont(ofSize: 40.0)
        default:
            gameBoardConstraint.constant = 0
            playerOneLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
            playerOneScore.font = UIFont.boldSystemFont(ofSize: 30.0)
            playerTwoLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
            playerTwoScore.font = UIFont.boldSystemFont(ofSize: 30.0)
        }
    }
    
    func resetBoard() {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        activePlayer = Int.random(in: 1..<3)
        UIView.animate(withDuration: 0.3) {
            self.endGameButton.isHidden = false
        }
        playAgainButton.isHidden = true
        playerWonLabel.isHidden = true
        newPlayersButton.isHidden = true
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
        if playerOneScore == 0 && playerTwoScore == 0 {
            return
        }
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
            self.playerOneView.backgroundColor = .white
            self.playerTwoView.backgroundColor = .white
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
            self.playerOneView.backgroundColor = .black
            self.playerTwoView.backgroundColor = .black
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

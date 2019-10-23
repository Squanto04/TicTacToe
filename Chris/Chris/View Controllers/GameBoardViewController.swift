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

    // MARK: - Outlets
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var turnPickerImageView: UIImageView!
    @IBOutlet weak var playerWonLabel: UILabel!
    @IBOutlet weak var newPlayersButton: TicTacToeButton!
    @IBOutlet weak var endGameButton: TicTacToeButton!
    @IBOutlet weak var playerAgainButton: TicTacToeButton!
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
    }
    
    // MARK: - Actions
    @IBAction func gameButtonTapped(_ sender: AnyObject) {
        
    }
    
    @IBAction func newPlayersButtonTapped(_ sender: Any) {
    }
    
    @IBAction func endGameButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playAgainButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        
    }
    
}

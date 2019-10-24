//
//  ScoreController.swift
//  Chris
//
//  Created by Christopher Alegre on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

class ScoreController {
    
    static let sharedScore = ScoreController()
    
    var scores: [Score] = []
    
    func setScore(playerOneScore: Int, playerTwoScore: Int, playerOne: Player, playerTwo: Player) {
        let newGameScore = Score(playerOne: playerOne, playerOneScore: playerOneScore, playerTwo: playerTwo, playerTwoScore: playerTwoScore)
        scores.append(newGameScore)
        PlayerController.shared.saveToPersistantStore()
    }
}

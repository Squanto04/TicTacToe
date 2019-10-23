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
    
    func setScore(score: Int, player: Player) {
        let newScore = Score(score: score, player: player)
        scores.append(newScore)
        PlayerController.shared.saveToPersistantStore()
    }
}

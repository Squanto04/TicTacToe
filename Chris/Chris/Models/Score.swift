//
//  Score.swift
//  Chris
//
//  Created by Christopher Alegre on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

class Score: Codable {
    var game: String
    var playerOne: Player
    var playerOneScore: Int
    var playerTwo: Player
    var playerTwoScore: Int
    var timestamp: Date
    
    init(game: String = UUID().uuidString, playerOne: Player, playerOneScore: Int, playerTwo: Player, playerTwoScore: Int, timestamp: Date = Date()) {
        self.game = game
        self.playerOne = playerOne
        self.playerOneScore = playerOneScore
        self.playerTwo = playerTwo
        self.playerTwoScore = playerTwoScore
        self.timestamp = timestamp
    }
}

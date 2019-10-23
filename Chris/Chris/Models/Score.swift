//
//  Score.swift
//  Chris
//
//  Created by Christopher Alegre on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

class Score: Codable {
    var score: Int
    var timestamp: Date
    var players: [Player]
    
    init(score: Int, timestamp: Date = Date(), players: [Player]) {
        self.score = score
        self.timestamp = timestamp
        self.players = players
    }
}

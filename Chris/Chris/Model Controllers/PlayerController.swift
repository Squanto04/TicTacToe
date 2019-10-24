//
//  PlayerController.swift
//  Chris
//
//  Created by Christopher Alegre on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

class PlayerController {
    
    static let shared = PlayerController()
    
    var players: [Player] = []
    var nightMode: Bool = false
    
    func createPlayer(name: String, icon: Bool) {
        let newPlayer = Player(name: name, icon: icon)
        players.append(newPlayer)
    }
}

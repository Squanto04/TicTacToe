//
//  Player.swift
//  Chris
//
//  Created by Christopher Alegre on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

class Player: Codable {
    var name: String
    var icon: Bool
    
    init(name: String, icon: Bool) {
        self.name = name
        self.icon = icon
    }
}


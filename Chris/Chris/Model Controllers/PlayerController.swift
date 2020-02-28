//
//  PlayerController.swift
//  Chris
//
//  Created by Christopher Alegre on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class PlayerController {
    
    static let shared = PlayerController()
    
    var players: [Player] = []
    var nightMode: Bool = false
    var current = UIStatusBarStyle.default
    
    func createPlayer(name: String, icon: Bool) {
        let newPlayer = Player(name: name, icon: icon)
        players.append(newPlayer)
    }
    
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("nightMode.json")
        return fileURL
    }
    
    func saveToPersistantStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let jsonNightMode = try jsonEncoder.encode(nightMode)
            try jsonNightMode.write(to: createFileForPersistence())
        } catch let encodingError {
            print("Error: Could not save data, \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistantStorage() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let jsonData = try Data(contentsOf: createFileForPersistence())
            let decodeNightModeData = try jsonDecoder.decode(Bool.self, from: jsonData)
            print(decodeNightModeData)
            nightMode = decodeNightModeData
        } catch let decodingError {
            print("Error: Could not retrieve data from storage: \(decodingError.localizedDescription).")
        }
    }
}

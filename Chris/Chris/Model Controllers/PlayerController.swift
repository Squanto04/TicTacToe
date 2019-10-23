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
    
    func createPlayer(name: String, icon: Bool) {
        let newPlayer = Player(name: name, icon: icon)
        players.append(newPlayer)
        saveToPersistantStore()
    }
    
    func createFileForPersistence() -> URL {
        //Grab users document directory
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //Create new fileURL on users phone
        let fileURL = urls[0].appendingPathComponent("Chris.json")
        return fileURL
    }

    func saveToPersistantStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let jsonChris = try jsonEncoder.encode(players)
            try jsonChris.write(to: createFileForPersistence())
        } catch let encodingError {
            print("Error: Could not save data, \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistantStorage() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let jsonData = try Data(contentsOf: createFileForPersistence())
            let decodeChrisData = try jsonDecoder.decode([Player].self, from: jsonData)
            players = decodeChrisData
        } catch let decodingError {
            print("Error: Could not retrieve data from storage, \(decodingError.localizedDescription)")
        }
    }
}

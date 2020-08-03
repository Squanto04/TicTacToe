//
//  ScoreController.swift
//  Chris
//
//  Created by Christopher Alegre on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

class ScoreController {
    
    static let shared = ScoreController()
    
    var scores: [Score] = []
    
    func setScore(playerOneScore: Int, playerTwoScore: Int, playerOne: Player, playerTwo: Player) {
        let newGameScore = Score(playerOne: playerOne, playerOneScore: playerOneScore, playerTwo: playerTwo, playerTwoScore: playerTwoScore)
        scores.append(newGameScore)
        saveToPersistantStore()
    }
    
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("TicTacToe-Scores.json")
        return fileURL
    }
    
    func saveToPersistantStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonScores = try jsonEncoder.encode(scores)
            try jsonScores.write(to: createFileForPersistence())
        } catch let encodingError {
            print("Error: Could not save data, \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistantStorage() {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: createFileForPersistence())
            let decodeChrisData = try jsonDecoder.decode([Score].self, from: jsonData)
            scores = decodeChrisData
        } catch let decodingError {
            print("Error: Could not retrieve data from storage, \(decodingError.localizedDescription)")
        }
    }
    
}

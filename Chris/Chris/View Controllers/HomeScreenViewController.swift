//
//  HomeScreenViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITextFieldDelegate {
    
    var nightMode = false

    // MARK: - Outlet
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var scoreBoardButton: UIButton!
    @IBOutlet weak var letsPlayButton: UIButton!
    @IBOutlet weak var nightModeLabel: UILabel!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func nightModeSwitchTapped(_ sender: Any) {
        if nightMode == false {
            turnNightModeOn()
            nightMode = true
        } else {
            turnNightModeOff()
            nightMode = false
        }
    }
    
    @IBAction func scoreBoardButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toScoreboardVC", sender: self)
    }
    
    @IBAction func letsPlayButtonTapped(_ sender: Any) {
        guard let playerOne = playerOneTextField.text,
            !playerOne.isEmpty,
            let playerTwo = playerTwoTextField.text,
            !playerTwo.isEmpty
            else { return }
        PlayerController.shared.createPlayer(name: playerOne, icon: true)
        PlayerController.shared.createPlayer(name: playerTwo, icon: false)
        
        performSegue(withIdentifier: "toGameboardVC", sender: self)
    }
    
    // MARK: - Helper Functions
    func turnNightModeOn() {
        self.view.backgroundColor = .black
        nightModeLabel.textColor = .white
    }
    
    func turnNightModeOff() {
        self.view.backgroundColor = .white
        nightModeLabel.textColor = .black
    }

}

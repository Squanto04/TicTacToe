//
//  HomeScreenViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITextFieldDelegate {
    
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
    @IBAction func tapGesture(_ sender: Any) {
        playerOneTextField.resignFirstResponder()
        playerTwoTextField.resignFirstResponder()
    }
    
    @IBAction func nightModeSwitchTapped(_ sender: Any) {
        if PlayerController.shared.nightMode == false {
            turnNightModeOn()
            PlayerController.shared.nightMode = true
        } else {
            turnNightModeOff()
            PlayerController.shared.nightMode = false
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
    
    // MARK: - Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        playerOneTextField.resignFirstResponder()
        playerTwoTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showTextFields(textfield: playerTwoTextField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        showTextFields(textfield: playerOneTextField, moveDistance: -250, up: false)
    }
    
    func showTextFields(textfield: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateNameTextFields", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

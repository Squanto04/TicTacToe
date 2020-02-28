//
//  HomeScreenViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    override  var preferredStatusBarStyle: UIStatusBarStyle {
        return PlayerController.shared.current
    }
    
    // MARK: - Outlet
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var scoreBoardButton: UIButton!
    @IBOutlet weak var letsPlayButton: UIButton!
    @IBOutlet weak var nightModeLabel: UILabel!
    @IBOutlet weak var nightModeSwitch: UISwitch!
    
    // Constraints
    @IBOutlet weak var playerNameStackView: UIStackView!
    @IBOutlet weak var topLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerNightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nightButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonsBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PlayerController.shared.loadFromPersistantStorage()
        updateNightMode()
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
            PlayerController.shared.current = PlayerController.shared.current == .default ? .lightContent : .default
            self.setNeedsStatusBarAppearanceUpdate()
        } else {
            turnNightModeOff()
            PlayerController.shared.nightMode = false
            PlayerController.shared.current = PlayerController.shared.current == .default ? .lightContent : .default
            self.setNeedsStatusBarAppearanceUpdate()
        }
        PlayerController.shared.saveToPersistantStore()
    }
    
    @IBAction func scoreBoardButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toScoreboardVC", sender: self)
    }
    
    @IBAction func letsPlayButtonTapped(_ sender: Any) {
        guard var playerOne = playerOneTextField.text,
            var playerTwo = playerTwoTextField.text
            else { return }
        if playerOne.isEmpty {
            playerOne = "Player 1"
        }
        if playerTwo.isEmpty {
            playerTwo = "Player 2"
        }
        PlayerController.shared.createPlayer(name: playerOne, icon: true)
        PlayerController.shared.createPlayer(name: playerTwo, icon: false)
        performSegue(withIdentifier: "toGameboardVC", sender: sender)
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
    
    // MARK: - Update Views
    func updateViews() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            let toolBarOne = UIToolbar().ToolbarPicker(#selector(clearOneText))
            let toolBarTwo = UIToolbar().ToolbarPicker(#selector(clearTwoText))
            playerOneTextField.inputAccessoryView = toolBarOne
            playerTwoTextField.inputAccessoryView = toolBarTwo
        } else {
            return
        }
        
        switch UIDevice().type {
        case .iPhoneSE, .iPhone4, .iPhone4S:
            topLogoConstraint.constant = 10
            playerNameStackView.spacing = 20
            playerNightConstraint.constant = 30
            nightButtonConstraint.constant = 33
            buttonsBottomConstraint.constant = 40
        case .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus:
            topLogoConstraint.constant = 20
            playerNameStackView.spacing = 30
            playerNightConstraint.constant = 40
            nightButtonConstraint.constant = 44
            buttonsBottomConstraint.constant = 50
        case .iPhoneX, .iPhoneXS, .iPhoneXR:
            topLogoConstraint.constant = 20
            playerNameStackView.spacing = 30
            playerNightConstraint.constant = 40
            nightButtonConstraint.constant = 40
            buttonsBottomConstraint.constant = 50
        case .iPhoneXSMax, .iPhone11, .iPhone11Pro, .iPhone11ProMax:
            topLogoConstraint.constant = 30
            playerNameStackView.spacing = 40
            playerNightConstraint.constant = 50
            nightButtonConstraint.constant = 50
            buttonsBottomConstraint.constant = 60
        default:
            topLogoConstraint.constant = 10
            playerNameStackView.spacing = 30
            playerNightConstraint.constant = 40
            nightButtonConstraint.constant = 40
            buttonsBottomConstraint.constant = 60
        }
    }
    
    func updateNightMode() {
        if PlayerController.shared.nightMode {
            self.turnNightModeOn()
            self.nightModeSwitch.isOn = true
        } else {
            self.turnNightModeOff()
            self.nightModeSwitch.isOn = false
        }
    }
    
    @objc func clearOneText() {
        playerOneTextField.text = ""
    }
    
    @objc func clearTwoText() {
        playerTwoTextField.text = ""
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

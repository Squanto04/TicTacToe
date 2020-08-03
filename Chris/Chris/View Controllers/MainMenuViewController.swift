//
//  MainMenuViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 6/16/20.
//  Copyright © 2020 Squanto Inc. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainMenuViewController: UIViewController {
    
    // MARK: - Properties
    var playerOneMode: Bool = true
    var onePlayerSpacing: CGFloat = 120.0
    var twoPlayerSpacing: CGFloat = 80.0
    override  var preferredStatusBarStyle: UIStatusBarStyle {
        return PlayerController.shared.current
    }
    
    // MARK: - Outlets
        // Buttons
    @IBOutlet weak var onePlayerButton: TicTacToeButton!
    @IBOutlet weak var twoPlayerButton: TicTacToeButton!
    @IBOutlet weak var settingsButton: TicTacToeButton!
    @IBOutlet weak var scoreboardButton: TicTacToeButton!
    @IBOutlet weak var letsPlayButton: TicTacToeButton!
    @IBOutlet weak var cancelButton: TicTacToeButton!
        // Text Fields
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
        // Views
    @IBOutlet weak var adBannerView: GADBannerView!
        // Stack View
    @IBOutlet weak var mainButtonsStackView: UIStackView!
    @IBOutlet weak var playerNameStackView: UIStackView!
        // Constraints
    @IBOutlet weak var mainButtonsConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerNamesConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerNamesDistantConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerNamesBottomDistantConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainButtonDistantConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainButtonBottomDistantConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBannerAds()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ScoreController.shared.loadFromPersistantStorage()
        adjustForNightMode()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mainMenuShiftRight()
        playerOneTextField.text = ""
        playerTwoTextField.text = ""
    }
    
    // MARK: - Actions
    @IBAction func playerOneTapped(_ sender: Any) {
        playerOneMode = true
        playerNamesDistantConstraint.constant = onePlayerSpacing
        playerTwoTextField.isHidden = true
        mainMenuShiftLeft()
    }
    
    @IBAction func playerTwoTapped(_ sender: Any) {
        playerOneMode = false
        playerNamesDistantConstraint.constant = twoPlayerSpacing
        playerTwoTextField.isHidden = false
        mainMenuShiftLeft()
    }
    
    @IBAction func letsPlayButtonTapped(_ sender: Any) {
        guard var playerOne = playerOneTextField.text,
            var playerTwo = playerTwoTextField.text
            else { return }
        if playerOne.isEmpty {
            playerOne = "Player 1"
        }
        if playerOneMode {
            playerTwo = "Computer"
        } else {
            if playerTwo.isEmpty {
                playerTwo = "Player 2"
            }
        }
        PlayerController.shared.createPlayer(name: playerOne, icon: true)
        PlayerController.shared.createPlayer(name: playerTwo, icon: false)
    }
    
    @IBAction func tapGestureTapped(_ sender: Any) {
        playerOneTextField.resignFirstResponder()
        playerTwoTextField.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        mainMenuShiftRight()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameBoardVC" {
            guard let destinationVC = segue.destination as? GameBoardViewController else { return }
            if playerOneMode {
                destinationVC.playerOneMode = true
            } else {
                destinationVC.playerOneMode = false
            }
        }
    }
    
    // MARK: - Helper Functions
    func mainMenuShiftLeft() {
        UIView.animate(withDuration: 1.0) {
            self.mainButtonsConstraint.constant = (0 - self.view.frame.width)
            self.playerNamesConstraint.constant = 0
        }
    }
    
    func mainMenuShiftRight() {
        UIView.animate(withDuration: 1.0) {
            self.mainButtonsConstraint.constant = 0
            self.playerNamesConstraint.constant = self.view.frame.width
        }
    }
    
    // MARK: - Setup Views
    func setupViews() {
        playerNamesConstraint.constant = view.frame.width
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
        case .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPadAir, .iPadAir2, .iPadAir3, .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5, .iPadPro11, .iPadPro9_7, .iPadPro10_5, .iPadPro12_9, .iPadPro2_12_9, .iPadPro3_12_9:
            mainButtonsConstraint.constant = 0
            playerNamesConstraint.constant = view.frame.width
            mainButtonDistantConstraint.constant = 20
            playerNamesDistantConstraint.constant = 20
            playerNamesBottomDistantConstraint.constant = 50
            mainButtonBottomDistantConstraint.constant = 50
            mainButtonsStackView.spacing = 30
            playerNameStackView.spacing = 30
            onePlayerSpacing = 80
            twoPlayerSpacing = 20
        case .iPhone8Plus, .iPhone8:
            mainButtonsConstraint.constant = 0
            playerNamesConstraint.constant = view.frame.width
            mainButtonDistantConstraint.constant = 30
            playerNamesDistantConstraint.constant = 30
            playerNamesBottomDistantConstraint.constant = 30
            mainButtonBottomDistantConstraint.constant = 30
            mainButtonsStackView.spacing = 15
            playerNameStackView.spacing = 15
            onePlayerSpacing = 80
            twoPlayerSpacing = 30
        case .iPhone4, .iPhone4S, .iPhone5, .iPhone5C, .iPhone5S, .iPhoneSE:
            mainButtonsConstraint.constant = 0
            playerNamesConstraint.constant = view.frame.width
            mainButtonDistantConstraint.constant = 10
            playerNamesDistantConstraint.constant = 10
            playerNamesBottomDistantConstraint.constant = 10
            mainButtonBottomDistantConstraint.constant = 10
            mainButtonsStackView.spacing = 15
            playerNameStackView.spacing = 15
            onePlayerSpacing = 70
            twoPlayerSpacing = 10
        default:
            mainButtonsConstraint.constant = 0
            playerNamesConstraint.constant = view.frame.width
            mainButtonDistantConstraint.constant = 80
            playerNamesDistantConstraint.constant = 80
            playerNamesBottomDistantConstraint.constant = 50
            mainButtonBottomDistantConstraint.constant = 50
            mainButtonsStackView.spacing = 30
            playerNameStackView.spacing = 30
            onePlayerSpacing = 120
            twoPlayerSpacing = 80
        }
    }
    
    // MARK: - Adjust For Night Mode
    func adjustForNightMode() {
        if PlayerController.shared.nightMode {
            view.backgroundColor = .darkerGray
            adBannerView.backgroundColor = .darkerGray
        } else {
            view.backgroundColor = UIColor.white
            adBannerView.backgroundColor = .white
        }
    }
    
}

// MARK: - Textfield Delegate
extension MainMenuViewController: UITextFieldDelegate {
    
    @objc func clearOneText() {
        playerOneTextField.text = ""
    }

    @objc func clearTwoText() {
        playerTwoTextField.text = ""
    }
    
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

// MARK: - Banner View Delegate
extension MainMenuViewController: GADBannerViewDelegate {
    
    func setUpBannerAds() {
        adBannerView.adUnitID = Constants.shared.mainMenuBannerUnitCode
        adBannerView.rootViewController = self
        adBannerView.load(GADRequest())
        adBannerView.delegate = self
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Received Ad")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error.localizedDescription)
    }
}

//
//  SettingsTableViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 6/16/20.
//  Copyright © 2020 Squanto Inc. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var nightModeSwitch: UISwitch!
    @IBOutlet weak var nightModeLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var supportLabel: UILabel!
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adjustForNightMode()
    }
    
    // MARK: - Actions
    @IBAction func homeButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nightModeSwitchTapped(_ sender: Any) {
        if PlayerController.shared.nightMode == false {
            PlayerController.shared.nightMode = true
            PlayerController.shared.current = PlayerController.shared.current == .default ? .lightContent : .default
            self.setNeedsStatusBarAppearanceUpdate()
        } else {
            PlayerController.shared.nightMode = false
            PlayerController.shared.current = PlayerController.shared.current == .default ? .lightContent : .default
            self.setNeedsStatusBarAppearanceUpdate()
        }
        PlayerController.shared.saveToPersistantStore()
        adjustForNightMode()
    }
    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 1 {
            contactSupportAlert()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Helper Functions
    func adjustForNightMode() {
        if PlayerController.shared.nightMode == true {
            nightModeSwitch.isOn = true
            view.backgroundColor = UIColor.darkerGray
            tableView.backgroundColor = UIColor.darkerGray
            nightModeLabel.textColor = .white
            privacyPolicyLabel.textColor = .white
            supportLabel.textColor = .white
        } else {
            nightModeSwitch.isOn = false
            view.backgroundColor = .white
            tableView.backgroundColor = .white
            nightModeLabel.textColor = .black
            privacyPolicyLabel.textColor = .black
            supportLabel.textColor = .black
        }
    }
    
    func noScoresToDisplay() {
        tableView.backgroundView = nil
    }
    
    func sendEmail() {
        let email = "jordanlamb.lls@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    // MARK: - Alert Controllers
    func contactSupportAlert() {
        let alert = UIAlertController(title: "Contact Support", message: nil, preferredStyle: .alert)
        let email = UIAlertAction(title: "Email", style: .default) { (_) in
            self.sendEmail()
        }
        alert.addAction(email)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

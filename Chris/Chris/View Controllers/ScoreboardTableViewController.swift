//
//  ScoreboardTableViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class ScoreboardTableViewController: UITableViewController {

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Actions
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearScoreTapped(_ sender: Any) {
        clearScoreAlert()
    }
    
    // MARK: - Setup Views
    func setupViews() {
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        if PlayerController.shared.nightMode {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    // MARK: - Alert Controllers
    func clearScoreAlert() {
        let alert = UIAlertController(title: "Clear Scores?", message: "Are you sure you want to clear all scores? This cannot be undone.", preferredStyle: .alert)
        let clearAlert = UIAlertAction(title: "Clear", style: .default) { (_) in
            ScoreController.sharedScore.scores = []
            self.tableView.reloadData()
            ScoreController.sharedScore.saveToPersistantStore()
        }
        alert.addAction(clearAlert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreController.sharedScore.scores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCell", for: indexPath) as? ScoreBoardTableViewCell else {return UITableViewCell()}
        let reversedScore: [Score] = ScoreController.sharedScore.scores.reversed()
        let score = reversedScore[indexPath.row]
        cell.score = score
        return cell
    }

}

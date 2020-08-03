//
//  ScoreboardTableViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class ScoreboardTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet var noScoresView: UIView!
    @IBOutlet weak var noScoresLabel: UILabel!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adjustScoreView()
    }
    
    // MARK: - Actions
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearScoreTapped(_ sender: Any) {
        clearScoreAlert()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreController.shared.scores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCell", for: indexPath) as? ScoreBoardTableViewCell else {return UITableViewCell()}
        let reversedScore: [Score] = ScoreController.shared.scores.reversed()
        let score = reversedScore[indexPath.row]
        cell.score = score
        return cell
    }
    
    // MARK: - Helper Functions
    func setupViews() {
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        adjustForNightMode()
    }
    
    func adjustScoreView() {
        if ScoreController.shared.scores.count == 0 {
            tableView.backgroundView = noScoresView
        } else {
            tableView.backgroundView = nil
        }
    }
    
    func adjustForNightMode() {
        if PlayerController.shared.nightMode {
            view.backgroundColor = .darkerGray
            noScoresView.backgroundColor = .darkerGray
            noScoresLabel.textColor = .white
        } else {
            view.backgroundColor = .white
            noScoresView.backgroundColor = .white
            noScoresLabel.textColor = .black
        }
    }

    // MARK: - Alert Controllers
    func clearScoreAlert() {
        let alert = UIAlertController(title: "Clear Scores?", message: "Are you sure you want to clear all scores? This cannot be undone.", preferredStyle: .alert)
        let clearAlert = UIAlertAction(title: "Clear", style: .default) { (_) in
            ScoreController.shared.scores = []
            self.tableView.reloadData()
            self.tableView.backgroundView = self.noScoresView
            ScoreController.shared.saveToPersistantStore()
        }
        alert.addAction(clearAlert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}

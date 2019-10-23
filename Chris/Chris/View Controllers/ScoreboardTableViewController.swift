//
//  ScoreboardTableViewController.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class ScoreboardTableViewController: UITableViewController {
    
    var scores: [Score] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreController.sharedScore.scores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scoreboardCell", for: indexPath) as? ScoreBoardTableViewCell else {return UITableViewCell()}
        cell.score = scores[indexPath.row]
        return cell
    }

}

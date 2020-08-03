//
//  TicTacToeButton.swift
//  Chris
//
//  Created by Jordan Lamb on 10/23/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class TicTacToeButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    func updateViews() {
        self.layer.cornerRadius = self.frame.height / 6
    }

}

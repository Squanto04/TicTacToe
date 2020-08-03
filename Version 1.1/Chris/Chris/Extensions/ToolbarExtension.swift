//
//  ToolbarExtension.swift
//  Chris
//
//  Created by Jordan Lamb on 2/27/20.
//  Copyright © 2020 Squanto Inc. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
extension UIToolbar {
    
    func ToolbarPicker(_ selector: Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .label
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: selector)
        
        toolBar.setItems([spaceButton, clearButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}

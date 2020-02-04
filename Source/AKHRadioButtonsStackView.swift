//
//  ViewController.swift
//  AKHRadioButton
//
//  Created by Alexey Khatmullin on 04.02.2020.
//  Copyright © 2020 Alexey Khatmullin. All rights reserved.
//

import UIKit


class AKHRadioButtonsStackView: UIStackView {
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    
    // MARK: - Setup
    
    fileprivate func setup() {
        axis = AKHRadioButton.Constants.defaultDirection
        spacing = AKHRadioButton.Constants.defaultDistanceBetweenElements
    }
    
}

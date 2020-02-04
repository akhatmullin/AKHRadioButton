//
//  ViewController.swift
//  AKHRadioButton
//
//  Created by Alexey Khatmullin on 04.02.2020.
//  Copyright © 2020 Alexey Khatmullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: - Properties
    
    @IBOutlet fileprivate var radioButton: AKHRadioButton!
    
    
    // MARK: - View Controller's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        radioButton.options = ["First", "Second", "Third", "Fourth", "Fifth"]
        radioButton.direction = .horizontal
    }
    
}

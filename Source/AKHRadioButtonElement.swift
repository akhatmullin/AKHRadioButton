//
//  ViewController.swift
//  AKHRadioButton
//
//  Created by Alexey Khatmullin on 04.02.2020.
//  Copyright © 2020 Alexey Khatmullin. All rights reserved.
//

import UIKit


class AKHRadioButtonElement: UIButton {
    
    
    // MARK: - Constants
    
    struct Constants {
        static let titleLeftPadding: CGFloat = 8
    }
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Override
    
    override func contentRect(forBounds bounds: CGRect) -> CGRect {
        return bounds
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0,
                      width: contentRect.size.height, height: contentRect.size.height)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageWidth = imageRect(forContentRect: contentRect).size.height
        return CGRect(x: imageWidth + Constants.titleLeftPadding, y: 0,
                      width: contentRect.size.width - imageWidth - Constants.titleLeftPadding, height: contentRect.size.height)
    }
    
}

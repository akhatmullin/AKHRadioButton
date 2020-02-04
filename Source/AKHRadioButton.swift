//
//  ViewController.swift
//  AKHRadioButton
//
//  Created by Alexey Khatmullin on 04.02.2020.
//  Copyright © 2020 Alexey Khatmullin. All rights reserved.
//

import UIKit


class AKHRadioButton: UIView {
    
    
    // MARK: - Constants
    
    struct Constants {
        static let defaultDirection: NSLayoutConstraint.Axis = .vertical
        static let defaultDistanceBetweenElements: CGFloat = 8
        static let defaultHeightOfElement: CGFloat = 20
        static let defaultFont = UIFont.systemFont(ofSize: 14)
        static let defaultTextColor = UIColor.black
        static let defaultNormalStateImage = UIImage(named: "radio_button_icon_off")!
        static let defaultSelectedStateImage = UIImage(named: "radio_button_icon_on")!
    }
    
    
    // MARK: - Properties
    
    // MARK: Public
    
    /// This property determines the orientation of the arranged views. Assigning the vertical value creates a column of views. Assigning the horizontal value creates a row. The default value is vertical.
    @IBInspectable var direction: NSLayoutConstraint.Axis = Constants.defaultDirection {
        didSet {
            stackView.axis = direction
        }
    }
    
    /// This property determines the distance between elements in the group of elements. The default value is 8.
    @IBInspectable var distanceBetweenElements: CGFloat = Constants.defaultDistanceBetweenElements {
        didSet {
            stackView.spacing = distanceBetweenElements
        }
    }
    
    /// This property determines the height of the elements. The default value is 20.
    @IBInspectable var heightOfElement: CGFloat = Constants.defaultHeightOfElement {
        didSet {
            for element in elements {
                var frame = element.bounds
                frame.size.height = heightOfElement
                element.frame = frame
            }
        }
    }
    
    /// This property determines font for titles in the group. The default value is system font with size 14.
    @IBInspectable var font: UIFont = Constants.defaultFont {
        didSet {
            for element in elements {
                element.titleLabel?.font = font
            }
        }
    }
    
    /// This property determines a color for the text. The default value is black color.
    @IBInspectable var textColor: UIColor = Constants.defaultTextColor {
        didSet {
            for element in elements {
                element.setTitleColor(textColor, for: .normal)
            }
        }
    }
    
    /// This property determines image for normal (deselected) state of elements.
    @IBInspectable var normalStateImage: UIImage = Constants.defaultNormalStateImage
    
    /// This property determines image for selected state of elements.
    @IBInspectable var selectedStateImage: UIImage = Constants.defaultSelectedStateImage
    
    /// This property determines a list of options for the radio button
    var options: [String] = [String]() {
        didSet {
            clearStackView()
            setupElements()
        }
    }
    
    
    // MARK: Private
    
    // A stack view (UIStackView) for elements of the radio button.
    fileprivate let stackView: AKHRadioButtonsStackView = AKHRadioButtonsStackView(frame: .zero)
    
    // An array of elements in the radio button.
    fileprivate var elements: [AKHRadioButtonElement] = [AKHRadioButtonElement]()
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    
    // MARK: - Setup
    
    fileprivate func setup() {
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        stackView.frame = bounds
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor).isActive = true
        stackView.axis = direction
    }
    
    fileprivate func setupElements() {
        for option in options {
            let element = AKHRadioButtonElement(frame: .zero)
            element.addTarget(self, action: #selector(selectElement(sender:)), for: .touchUpInside)
            element.setTitle(option, for: .normal)
            element.setTitleColor(textColor, for: .normal)
            element.setImage(normalStateImage, for: .normal)
            element.setImage(selectedStateImage, for: .selected)
            element.titleLabel?.font = font
            element.titleLabel?.lineBreakMode = .byTruncatingTail
            
            let textWidth = sizeOfString(string: option,
                                         constrainedToWidth: bounds.size.width,
                                         constrainedToHeight: heightOfElement,
                                         withAttributes: [NSAttributedString.Key.font : font]).width
            let elementWidth = textWidth + AKHRadioButtonElement.Constants.titleLeftPadding + heightOfElement
            element.frame = CGRect(x: 0, y: 0, width: elementWidth, height: heightOfElement)
            
            elements.append(element)
            stackView.addArrangedSubview(element)
        }
    }
    
    
    // MARK: - Private Functions
    
    fileprivate func clearStackView() {
        for element in elements {
            stackView.removeArrangedSubview(element)
        }
        elements.removeAll()
    }
    
    @objc fileprivate func selectElement(sender: AKHRadioButtonElement) {
        for element in elements {
            element.isSelected = false
        }
        sender.isSelected = true
    }
    
    /// It's a function for calculate text's rectangle's size
    ///
    /// - parameter string: text (as String) for calculations
    /// - parameter width:  maximal width (as CGFloat) for the text's rectangle
    /// - parameter height: maximal height (as CGFloat) for the text's rectangle
    /// - parameter attributes: text's attributes
    ///
    /// - returns: size of the text's rectangle as CGSize
    private func sizeOfString(string: String, constrainedToWidth width: CGFloat, constrainedToHeight height: CGFloat, withAttributes attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let rectForString = (string as NSString).boundingRect(with: CGSize(width: width, height: height),
                                                              options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                              attributes: attributes,
                                                              context: nil)
        let sizeOfString = CGSize(width: rectForString.origin.x + rectForString.size.width, height: rectForString.origin.y + rectForString.size.height)
        
        return sizeOfString
    }
    
}

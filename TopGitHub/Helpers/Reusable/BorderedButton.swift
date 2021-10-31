//
//  BorderedButton.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 29/10/21.
//

import UIKit
@IBDesignable

open class BorderButton: UIButton {
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Properties
    open override var isEnabled: Bool {
        didSet {
            layer.backgroundColor = isEnabled ? UIColor.darkBlueColor.cgColor : UIColor.darkBlueColorWithOpacity.cgColor
            isUserInteractionEnabled = isEnabled
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    var isBorderedEnabled: Bool  = false {
        didSet {
            isBorderedEnabled ? self.setTitleColor(UIColor.darkBlueColor, for: .normal) :  self.setTitleColor(UIColor.darkBlueColorWithOpacity, for: .normal)
            isUserInteractionEnabled = isBorderedEnabled
        }
    }
    
    var setBorder: Bool = false {
        didSet {
            layer.borderWidth = 1
            layer.borderColor = UIColor.darkBlueColor.cgColor
            layer.backgroundColor = UIColor.white.cgColor
            self.setTitleColor(UIColor.darkBlueColor, for: .normal)
        }
    }
    
    // MARK: - Methods
    private func setup() {
        layer.backgroundColor = UIColor.darkBlueColorWithOpacity.cgColor
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 4
        titleLabel?.font = AppFont.medium.size(14.0)
    }
}

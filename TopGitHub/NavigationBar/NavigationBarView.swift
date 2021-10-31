//
//  NavigationBarView.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//


import UIKit

// MARK: - NavigationBarViewProtocol
protocol NavigationBarViewProtocol: AnyObject {
    func didTapLeftBarbutton(_ buttonType: NavigationBarButtonType?, sender: Any)
    func didTapRightBarbutton(_ buttonType: NavigationBarButtonType?, sender: Any)
}

class NavigationBarView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var leftBarButton: UIButton!
    @IBOutlet private weak var rightBarButton: UIButton!
    @IBOutlet private weak var trailingToSuperViewConstraint: NSLayoutConstraint!

    // MARK: - Properties
    weak var delegate: NavigationBarViewProtocol?
    var addShadow: Bool = false
    var contentView: UIView?


    open var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.font = AppFont.medium.size(14.0)
            titleLabel.textColor = .white
        }
    }
    // the right most button
    open var primaryRightBarButtonType: NavigationBarButtonType? = .filter {
        didSet {
            setupPrimaryRightBarbutton()
        }
    }
    
    open var leftBarButtonType: NavigationBarButtonType? = .back {
        didSet {
            setupLeftBarbutton()
        }
    }
    
    private func setupPrimaryRightBarbutton() {
        rightBarButton.isHidden = false
        if let iconName = primaryRightBarButtonType?.iconName {
            let templateImage = UIImage(named: iconName)?.withRenderingMode(.automatic)
            rightBarButton.setImage(templateImage, for: UIControl.State.normal)
        }
    }
    
    private func setupLeftBarbutton() {
        leftBarButton.isHidden = false
        if let iconName = leftBarButtonType?.iconName {
            let templateImage = UIImage(named: iconName)?.withRenderingMode(.automatic)
            leftBarButton.setImage(templateImage, for: UIControl.State.normal)
        }
    }
    
    // MARK: - View life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
        
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        contentView?.backgroundColor = .darkBlueColor
    
    }
    
    // Load Header view nib from the .xib file
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NavigationBarView", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    // Render the view in Interface Builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    // MARK: - Methods
    func setTitleAlignmentToCenter() {
        titleLabel.font = AppFont.medium.size(16.0)
        titleLabel.textAlignment = .center
    }

    // MARK: - Button Actions
    @IBAction func didTapLeftBarButton(_ sender: Any) {
        delegate?.didTapLeftBarbutton(leftBarButtonType, sender: sender)
    }
    
    @IBAction func didTapPrimaryRightBarButton(_ sender: Any) {
        delegate?.didTapRightBarbutton(primaryRightBarButtonType, sender: sender)
    }
}

// MARK: - NavigationBarButtonTypes
enum NavigationBarButtonType: Int {
    case back
    case filter
    case share
    
    public var iconName: String? {
        switch self {
        case .back:
            return "back"
        case .filter:
            return "filter"
        case .share:
            return "share"
        }
    }
}

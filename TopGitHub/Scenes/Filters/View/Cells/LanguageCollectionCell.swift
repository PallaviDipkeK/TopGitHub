//
//  LanguageCollectionCell.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 29/10/21.
//

import UIKit

// MARK: - FilterTableViewCellProtocol
protocol LanguageResponseProtocol: class {
    func didTapOnFilter(_ selectedFilter: LanguageResponseProtocol)
}

class LanguageCollectionCell: UICollectionViewCell , NibReusable {
    
    var languageSelected:(() -> Void)?
    // MARK: - IBOutlets
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    @IBOutlet private weak var languageButton: BorderButton!
    @IBOutlet private weak var mainView: UIView!
    // MARK: - View life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        languageButton.setTitle("", for: .normal)
    }
    
    // MARK: - Methods
    func configureCell(language: LanguageResponse) {
        languageButton.setTitle(language.language_Name, for: .normal)
        let titleWidth = language.language_Name?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]).width ?? 0
        buttonWidth.constant = titleWidth + 20
        updateConstraints()
        if language.isSelected {
            languageButton.isEnabled = true
        } else {
            languageButton.setBorder = true
        }
    }
    
    @IBAction private func languageSelected(_ sender: Any) {
        languageSelected?()
    }
}

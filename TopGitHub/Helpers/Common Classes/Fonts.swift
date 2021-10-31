//
//  Fonts.swift
//  AnujApp
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//

import Foundation
import UIKit

private let familyName = "Montserrat"

// MARK: - App Font
enum AppFont: String {
    case light = "Light"
    case regular = "Regular"
    case bold = "Bold"
    case medium = "Medium"
    case semiBold = "SemiBold"
    
    // MARK: - Methods
    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}

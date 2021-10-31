//
//  Strings+Extensions.swift
//  TopGitHub
//
//  Created by Pallavi Anant Dipke on 31/10/21.
//

import Foundation
import UIKit

// MARK: - NSMutableAttributedString Extension
extension NSMutableAttributedString {
    
    // MARK: - Methods
    func highlightedSubstring(_ substring: String,
                              withFont font: UIFont,
                              color: UIColor?) -> NSMutableAttributedString {
        let string = self.string as NSString
        let range = string.range(of: substring, options: NSString.CompareOptions.caseInsensitive)
        if range.location != NSNotFound && range.length > 0 {
            let str = self
            if let color = color {
                str.setAttributes([NSAttributedString.Key.font: font,
                                   NSAttributedString.Key.foregroundColor:color],
                                   range: range)
            } else {
                str.setAttributes([NSAttributedString.Key.font: font], range: range)
            }
            return str
        }
        return NSMutableAttributedString(string: self.string, attributes: nil)
    }
}

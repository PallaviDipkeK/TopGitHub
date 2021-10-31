//
//  Colors.swift
//  AnujApp
//
//  Created by Pallavi Anant Dipke on 27/10/21.
//

import UIKit
import Foundation

extension UIColor {
    // MARK: - Color properties
    @nonobjc class var darkBlueColor: UIColor {
        return UIColor(hexFromString: "#2F4F4F")
    }
    
    @nonobjc class var darkBlueColorWithOpacity: UIColor {
        return UIColor(hexFromString: "#2F4F4F", alpha: 0.5)
    }
    
    @nonobjc class var greenColor: UIColor {
        return UIColor(hexFromString: "#50C878", alpha: 0.2)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red)/255,
                  green: CGFloat(green)/255,
                  blue: CGFloat(blue)/255,
                  alpha: alpha)
    }
    
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if (cString.count) == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}

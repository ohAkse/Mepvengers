//
//  Theme.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import UIKit


enum ThemeColor: String {
    
    case pureBlack = "000000"
    case pureWhite = "ffffff"
    case darkBlack = "252525"
    case darkRed = "b41b1b"
    
    var color: UIColor {
        let hex = Int(self.rawValue, radix: 16)
        return UIColor(rgb: hex ?? 0x000000)
    }
}

extension UIColor {
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

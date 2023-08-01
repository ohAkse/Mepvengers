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





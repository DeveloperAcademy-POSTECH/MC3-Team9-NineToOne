//
//  UIColor+Extension.swift
//  GaNaDa
//
//  Created by Somin Park on 2022/07/22.
//

import UIKit

enum AssetsColor {
    case brand, subBrand, customGreen, customRed, customGray, customLightgray
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static func customColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .brand:
            return UIColor(rgb:  0x217CE6)
        case .subBrand:
            return UIColor(rgb: 0x7DBAFC)
        case .customGreen:
            return UIColor(rgb: 0x57CA44)
        case .customRed:
            return UIColor(rgb: 0xE31109)
        case .customGray:
            return UIColor(rgb: 0x979797)
        case .customLightgray:
            return UIColor(rgb: 0xFAFAFB)
        }
    }
}

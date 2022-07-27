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
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    static func customColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .brand:
            return UIColor(hex: 0x217CE6)
        case .subBrand:
            return UIColor(hex: 0x7DBAFC)
        case .customGreen:
            return UIColor(hex: 0x57CA44)
        case .customRed:
            return UIColor(hex: 0xE31109)
        case .customGray:
            return UIColor(hex: 0x767676)
        case .customLightgray:
            return UIColor(hex: 0xFAFAFB)
        }
    }
}

//
//  UIFont+Extension.swift
//  GaNaDa
//
//  Created by Somin Park on 2022/07/22.
//

import UIKit

enum AssetsFont {
    case content, subContent, customText, customHeader, customAnswer
}

extension UIFont {
    static func customFont(_ name: AssetsFont) -> UIFont {
        switch name {
        case .content:
            return UIFont(name: "Pretendard-SemiBold", size: 14)!
        case .subContent:
            return UIFont(name: "Pretendard-SemiBold", size: 12)!
        case .customText:
            return UIFont(name: "Pretendard-SemiBold", size: 10)!
        case .customHeader:
            return UIFont(name: "Pretendard-SemiBold", size: 18)!
        case .customAnswer:
            return UIFont(name: "NanumPenOTF", size: 25)!
        }
    }
}

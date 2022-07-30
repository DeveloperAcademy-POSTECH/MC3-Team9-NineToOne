//
//  UserLevel.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/29.
//

import Foundation
import UIKit

enum LevelCase: String, CaseIterable {
    case 학동
    case 유생
    case 급제
    case 종9품
    case 정9품
    case 종8품
    case 정8품
    case 종7품
    case 정7품
    case 종6품
    case 정6품
    case 종5품
    case 정5품
    case 종4품
    case 정4품
    case 종3품
    case 정3품
    case 종2품
    case 정2품
    case 종1품
    case 정1품
    case 세종대왕
    
    static func level(exp: Int) -> LevelCase {
        if exp > self.allCases.count * 100 {
            return .세종대왕
        }
        let index = exp / 100
        return self.allCases[index]
    }
    
    var levelImage: UIImage? {
        switch self {
        case .학동, .유생, .급제, .세종대왕:
            return UIImage(named: "Level\(LevelCase.allCases.firstIndex(of: self) ?? 1)")
        default:
            return UIImage(named: "Level")
        }
    }
}

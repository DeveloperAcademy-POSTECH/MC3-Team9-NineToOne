//
//  UserLevel.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/29.
//

import Foundation

enum level: Int {
    case lowNine = 0
    case highNine
    case lowEight
    case highEight
    case lowSeven
    case highSeven
    case lowSix
    case highSix
    case lowFive
    case highFive
    case lowFour
    case highFour
    case lowThree
    case highThree
    case lowTwo
    case highTwo
    case lowOne
    case highOne
    
    var name: String {
        switch self {
        case .lowNine:
            return "종 9품"
        case .highNine:
            return "정 9품"
        case .lowEight:
            return "종 8품"
        case .highEight:
            return "정 8품"
        case .lowSeven:
            return "종 7품"
        case .highSeven:
            return "정 7품"
        case .lowSix:
            return "종 6품"
        case .highSix:
            return "정 6품"
        case .lowFive:
            return "종 5품"
        case .highFive:
            return "정 5품"
        case .lowFour:
            return "종 4품"
        case .highFour:
            return "정 4품"
        case .lowThree:
            return "종 3품"
        case .highThree:
            return "정 3품"
        case .lowTwo:
            return "종 2품"
        case .highTwo:
            return "정 2품"
        case .lowOne:
            return "종 1품"
        case .highOne:
            return "정 1품"
        }
    }
}

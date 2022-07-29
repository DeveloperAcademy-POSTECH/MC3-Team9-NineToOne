//
//  TodayQuizViewController.swift
//  GaNaDa
//
//  Created by 김민택 on 2022/07/27.
//

import Foundation
import UIKit

class TodayQuizViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userExp: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveUserData(userName: "박가네감자탕둘째며느리의셋째아들")
        requestUserData()
        
        userExp.layer.sublayers![1].cornerRadius = 6
        userExp.subviews[1].clipsToBounds = true
    }
    
    func saveUserData(userName: String) {
        if UserDefaults.standard.object(forKey: "userName") == nil {
            UserDefaults.standard.setValue(userName, forKey: "userName")
            UserDefaults.standard.setValue(280, forKey: "userExp")
        }
    }
    
    func requestUserData() {
        userLevel.text = level(rawValue: UserDefaults.standard.integer(forKey: "userExp") / 100)?.name
        userName.text = UserDefaults.standard.string(forKey: "userName")
        userExp.progress = Float(UserDefaults.standard.integer(forKey: "userExp") % 100) / 100.0
    }
}

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

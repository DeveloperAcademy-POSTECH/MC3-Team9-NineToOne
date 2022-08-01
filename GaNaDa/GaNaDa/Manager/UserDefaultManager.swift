//
//  UserDefaultManager.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/08/01.
//

import Foundation

enum UserDefaultManager: String {
    case userNameKey = "USER_NAME"
    case userExpKey = "USER_EXP"
    case pushNotificationKey = "PUSH_NOTIFICATION"
    
    static var uds: UserDefaults {
        return UserDefaults.standard
    }
    
    static var userName: String {
        return uds.string(forKey: userNameKey.rawValue) ?? ""
    }
    
    static var userExp: Int {
        return uds.integer(forKey: userExpKey.rawValue)
    }
    
    static func initUserInfo() {
        let userName = "박가네감자탕둘째며느리"
        if uds.string(forKey: userNameKey.rawValue) == nil {
            uds.setValue(userName, forKey: userNameKey.rawValue)
            uds.setValue(220, forKey: userExpKey.rawValue)
        }
    }
    
    static func setUserName(name: String) {
        uds.setValue(name, forKey: userNameKey.rawValue)
    }
    
    static func setUserExp(exp: Int) {
        uds.setValue(exp, forKey: userExpKey.rawValue)
    }
}

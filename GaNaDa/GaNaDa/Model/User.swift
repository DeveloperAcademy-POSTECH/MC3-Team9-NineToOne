//
//  User.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/25.
//

import Foundation

struct User: Codable {
    var id: String
    var exp: Int
}

extension User {
    static var preview: User {
        return User(id: "1234-ABCD-5678-EFGH",
                    exp: 10)
    }
}

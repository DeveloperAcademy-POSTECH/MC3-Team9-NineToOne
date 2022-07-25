//
//  SubmitAnswerDTO.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/25.
//

import Foundation

struct SubmitAnswerDTO: Codable {
    let quizID: Int
    let userID: String
    let answer: String
}

extension SubmitAnswerDTO {
    static var preview: SubmitAnswerDTO {
        return SubmitAnswerDTO(quizID: 1,
                               userID: "1A5D1281-BCD0-4A9E-8752-F8E124DABD7C",
                               answer: "뵙겠습니다")
    }
}

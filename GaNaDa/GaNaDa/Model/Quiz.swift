//
//  Quiz.swift
//  GaNaDa
//
//  Created by hyo on 2022/07/25.
//

import Foundation

struct Quiz: Codable {
    var quizID: Int = 0
    let question: String
    let type: QuizType
    let rightAnswer: String
    let wrongAnswer: String
    var description: String = ""
    var example: [String] = []
}

enum QuizType: String, Codable {
    case Blank
    case choice
}

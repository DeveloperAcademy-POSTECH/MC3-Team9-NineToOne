//
//  HistoryQuiz.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/27.
//

import Foundation

struct HistoryQuiz: Codable {
    var quizID: Int = 0
    let question: String
    let type: QuizType
    let rightAnswer: String
    let wrongAnswer: String
    var description: String = ""
    var example: [String] = []
    var publishedDate: Date?
    var status: Int = 0
}

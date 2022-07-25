//
//  Quiz.swift
//  GaNaDa
//
//  Created by hyo on 2022/07/25.
//

import Foundation

struct Quiz {
    let question: String
    let type: QuizType
    let rightAnswer: String
    let wrongAnswer: String
}

enum QuizType {
    case Blank
    case choice
}

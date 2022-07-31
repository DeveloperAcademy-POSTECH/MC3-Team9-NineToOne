//
//  QuizDTO.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/31.
//

import Foundation

struct QuizDTO: Codable {
    var quizID: Int
    var question: String
    var type: String
    var rightAnswer: String
    var wrongAnswer: String
    var description: String
    var example: [String]
    
    var quiz: Quiz {
        return Quiz(quizID: self.quizID,
                    question: self.question,
                    typeRawValue: (self.type == "choice") ? 1 : 0,
                    rightAnswer: self.rightAnswer,
                    wrongAnswer: self.wrongAnswer,
                    description: self.description,
                    example: self.example
                    )
    }
}

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
    var stateRawValue: Int = 0
    var publishedDate: Date?
    
    var quizState: QuizState {
        return QuizState(rawValue: stateRawValue) ?? QuizState.unsolved
    }
}

enum QuizState: Int, Codable {
    case unsolved
    case rigth
    case wrong
}

enum QuizType: String, Codable {
    case blank
    case choice
}

extension Quiz {
    static var preview: Quiz {
        return Quiz(quizID: 0,
                    question: "무엇이 맞을까요?",
                    type: .choice,
                    rightAnswer: "뵙겠습니다",
                    wrongAnswer: "봽겠습니다",
                    description: "‘뵙겠습니다’가 맞습니다. ‘뵙겠습니다’의 기본형은 ‘뵙다(뵈다)’입니다.\n높임의 표현으로 ‘뵐까요?, 뵙도록 해요, 뵙죠’처럼 쓸 수 있습니다. ‘봬’는 ‘뵈어’의 준말입니다. ‘봬요(뵈어요), 뵀습니다(뵈었습니다)’처럼 ‘뵈’ 뒤에 ‘어’가 붙을 때는 이를 줄여서‘봬’로 쓸 수 있습니다. 따라서 ‘봴까요(X), 봽도록 해요(X), 봽죠(X)’ 모두 틀린 표기입니다.",
                    example: ["- 내일 2시에 뵙겠습니다.",
                              "- 교수님을 뵈러 가요"])
    }
}

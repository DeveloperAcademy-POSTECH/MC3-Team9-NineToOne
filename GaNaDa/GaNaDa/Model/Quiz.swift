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
    var wasSolved: Bool = false
    var isCorrect: Bool
}

enum QuizType: String, Codable {
    case blank
    case choice
}

extension Quiz {
    static var preview: [Quiz] {
        return [Quiz(quizID: 0,
                    question: "무엇이 맞을까요?",
                    type: .choice,
                    rightAnswer: "뵙겠습니다",
                    wrongAnswer: "봽겠습니다",
                    description: "‘뵙겠습니다’가 맞습니다. ‘뵙겠습니다’의 기본형은 ‘뵙다(뵈다)’입니다.\n높임의 표현으로 ‘뵐까요?, 뵙도록 해요, 뵙죠’처럼 쓸 수 있습니다. ‘봬’는 ‘뵈어’의 준말입니다. ‘봬요(뵈어요), 뵀습니다(뵈었습니다)’처럼 ‘뵈’ 뒤에 ‘어’가 붙을 때는 이를 줄여서‘봬’로 쓸 수 있습니다. 따라서 ‘봴까요(X), 봽도록 해요(X), 봽죠(X)’ 모두 틀린 표기입니다.",
                    example: ["- 내일 2시에 뵙겠습니다.",
                              "- 교수님을 뵈러 가요"],
                    wasSolved: true,
                    isCorrect: false),
                Quiz(quizID: 1,
                    question: "나는 iOS 개발자가 * 싶다.",
                    type: .blank,
                    rightAnswer: "되고",
                    wrongAnswer: "돼고",
                    description: "'되고'가 맞고 '돼고'는 안됩니다. 왜냐면 안되기때문이죠",
                    example: ["나는 개발자가 되고싶다.",
                              "나는 디자이너가 되고싶다."],
                    wasSolved: true,
                    isCorrect: false),
                Quiz(quizID: 2,
                    question: "나는 iOS 개발자가 * 싶다.",
                    type: .blank,
                    rightAnswer: "되고",
                    wrongAnswer: "돼고",
                    description: "'되고'가 맞고 '돼고'는 안됩니다. 왜냐면 안되기때문이죠",
                    example: ["나는 개발자가 되고싶다.",
                              "나는 디자이너가 되고싶다."],
                    wasSolved: true,
                    isCorrect: true),
                Quiz(quizID: 4,
                    question: "나는 iOS 개발자가 * 싶다.",
                    type: .blank,
                    rightAnswer: "되고",
                    wrongAnswer: "돼고",
                    description: "'되고'가 맞고 '돼고'는 안됩니다. 왜냐면 안되기때문이죠",
                    example: ["나는 개발자가 되고싶다.",
                              "나는 디자이너가 되고싶다."],
                    wasSolved: false,
                    isCorrect: false),
                Quiz(quizID: 5,
                    question: "무엇이 맞을까요?",
                    type: .choice,
                    rightAnswer: "뵙겠습니다",
                    wrongAnswer: "봽겠습니다",
                    description: "‘뵙겠습니다’가 맞습니다. ‘뵙겠습니다’의 기본형은 ‘뵙다(뵈다)’입니다.\n높임의 표현으로 ‘뵐까요?, 뵙도록 해요, 뵙죠’처럼 쓸 수 있습니다. ‘봬’는 ‘뵈어’의 준말입니다. ‘봬요(뵈어요), 뵀습니다(뵈었습니다)’처럼 ‘뵈’ 뒤에 ‘어’가 붙을 때는 이를 줄여서‘봬’로 쓸 수 있습니다. 따라서 ‘봴까요(X), 봽도록 해요(X), 봽죠(X)’ 모두 틀린 표기입니다.",
                    example: ["- 내일 2시에 뵙겠습니다.",
                              "- 교수님을 뵈러 가요"],
                    wasSolved: true,
                    isCorrect: true),
                Quiz(quizID: 6,
                    question: "무엇이 맞을까요?",
                    type: .choice,
                    rightAnswer: "뵙겠습니다",
                    wrongAnswer: "봽겠습니다",
                    description: "‘뵙겠습니다’가 맞습니다. ‘뵙겠습니다’의 기본형은 ‘뵙다(뵈다)’입니다.\n높임의 표현으로 ‘뵐까요?, 뵙도록 해요, 뵙죠’처럼 쓸 수 있습니다. ‘봬’는 ‘뵈어’의 준말입니다. ‘봬요(뵈어요), 뵀습니다(뵈었습니다)’처럼 ‘뵈’ 뒤에 ‘어’가 붙을 때는 이를 줄여서‘봬’로 쓸 수 있습니다. 따라서 ‘봴까요(X), 봽도록 해요(X), 봽죠(X)’ 모두 틀린 표기입니다.",
                    example: ["- 내일 2시에 뵙겠습니다.",
                              "- 교수님을 뵈러 가요"],
                    wasSolved: false,
                    isCorrect: false)]
    }
}

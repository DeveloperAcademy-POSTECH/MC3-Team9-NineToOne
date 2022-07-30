//
//  Quiz.swift
//  GaNaDa
//
//  Created by hyo on 2022/07/25.
//

import Foundation
import GameplayKit

struct Quiz: Codable {
    var quizID: Int = 0
    let question: String
    var typeRawValue: Int = 0
    let rightAnswer: String
    let wrongAnswer: String
    var description: String = ""
    var example: [String] = []
    var stateRawValue: Int = 0
    var publishedDate: Date?
    
    var isLeftAnswer: Bool {
        let generator = GKMersenneTwisterRandomSource(seed: UInt64(quizID))
        let randomBool = GKRandomDistribution(randomSource: generator,
                                       lowestValue: 1,
                                       highestValue: 3).nextBool()
        return randomBool
    }
    
    var quizType: QuizType {
        return QuizType(rawValue: typeRawValue) ?? QuizType.blank
    }
    var quizState: QuizState {
        return QuizState(rawValue: stateRawValue) ?? QuizState.unsolved
    }
}

enum QuizState: Int, Codable {
    case unsolved
    case right
    case wrong
}

enum QuizType: Int, Codable {
    case blank
    case choice
}

extension Quiz {
    static var previewChoice: Quiz {
        return Quiz(quizID: 0,
                    question: "무엇이 맞을까요?",
                    typeRawValue: 0,
                    rightAnswer: "뵙겠습니다",
                    wrongAnswer: "봽겠습니다",
                    description: "‘뵙겠습니다’가 맞습니다. ‘뵙겠습니다’의 기본형은 ‘뵙다(뵈다)’입니다.\n높임의 표현으로 ‘뵐까요?, 뵙도록 해요, 뵙죠’처럼 쓸 수 있습니다. ‘봬’는 ‘뵈어’의 준말입니다. ‘봬요(뵈어요), 뵀습니다(뵈었습니다)’처럼 ‘뵈’ 뒤에 ‘어’가 붙을 때는 이를 줄여서‘봬’로 쓸 수 있습니다. 따라서 ‘봴까요(X), 봽도록 해요(X), 봽죠(X)’ 모두 틀린 표기입니다.",
                    example: ["- 내일 2시에 뵙겠습니다.",
                              "- 교수님을 뵈러 가요"])
    }
    
    static var previewBlank: Quiz {
        return Quiz(quizID: 0,
                    question: "할 수 있는 사람이 * 없어",
                    typeRawValue: 0,
                    rightAnswer: "너밖에",
                    wrongAnswer: "너 밖에",
                    description: "해당 문장은 '그것 말고는', '그것 이외에는', '기꺼이 받아들이는', '피할 수 없는'의 뜻을 나타내는 보조사인 '밖에'가 사용된 문장입니다. 체언과 조사는 붙여 쓰는 것이 원칙이기 때문에 '너밖에'가 옳습니다.",
                    example: ["- 갈 수 있는 곳이 학교밖에 없어",
                              "- 그 사람은 돈밖에 모르는 사람이야"])
    }
}

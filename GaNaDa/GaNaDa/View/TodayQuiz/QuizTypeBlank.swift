//
//  QuizType1.swift
//  GaNaDa
//
//  Created by hyo on 2022/07/24.
//

import UIKit

final class QuizTypeBlank: UICollectionViewCell {
    @IBOutlet weak var quizIndex: UILabel!
    @IBOutlet weak var quizQuestion: UILabel!
    @IBOutlet weak var rightAnswer: UIButton!
    @IBOutlet weak var wrongAnswer: UIButton!

    var data: Quiz = Quiz(question: "샘플 문장", type: QuizType.blank, rightAnswer: "정답", wrongAnswer: "오답") {
        didSet {
            quizQuestion.text = makeQuizSentence(quiz: data)
            rightAnswer.setTitle(data.rightAnswer, for: UIControl.State.normal)
            wrongAnswer.setTitle(data.wrongAnswer, for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = QuizType1LayoutValue.Cell.cornerLadius
    }
}

private extension QuizTypeBlank {
    func makeQuizSentence(quiz: Quiz) -> String {
        var quizQuestion = quiz.question
        quizQuestion = quizQuestion.replacingOccurrences(of: "*", with: String(repeating: "_", count: quiz.rightAnswer.count + 2))
        return quizQuestion
    }
    
    struct QuizType1LayoutValue {
        enum Cell {
            static let cornerLadius = 16.0
        }
    }
}

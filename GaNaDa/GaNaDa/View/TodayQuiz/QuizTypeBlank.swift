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

    var data: Quiz = Quiz(question: "샘플 문장", type: QuizType.blank, rightAnswer: "정답", wrongAnswer: "오답") {
        didSet {
            quizQuestion.text = makeQuizSentence(quiz: data)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = QuizType1LayoutValue.Cell.cornerLadius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.customOrange.cgColor
    }
}

private extension QuizTypeBlank {
    func makeQuizSentence(quiz: Quiz) -> String {
        var quizQuestion = quiz.question
        quizQuestion = quizQuestion.replacingOccurrences(of: "*", with: "( \(data.rightAnswer) / \(data.wrongAnswer) )")
        return quizQuestion
    }
    
    struct QuizType1LayoutValue {
        enum Cell {
            static let cornerLadius = 16.0
        }
    }
}

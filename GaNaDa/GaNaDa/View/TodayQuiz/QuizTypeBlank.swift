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
        contentView.layer.cornerRadius = TodayQuizLayoutValue.CornerRadius.cell
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.customOrange.cgColor
    }
}

extension QuizTypeBlank {
    func makeQuizSentence(quiz: Quiz) -> String {
        var quizQuestion = quiz.question
        quizQuestion = quizQuestion.replacingOccurrences(of: "*", with: "( \(data.rightAnswer) / \(data.wrongAnswer) )")
        return quizQuestion
    }
}

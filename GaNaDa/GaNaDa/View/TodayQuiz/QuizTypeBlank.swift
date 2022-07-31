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

    var data: Quiz = Quiz(question: "샘플 문장", typeRawValue: 0, rightAnswer: "정답", wrongAnswer: "오답") {
        didSet {
            quizQuestion.text = makeQuizSentence(quiz: data)
            quizQuestion.font = .customFont(.content)
            quizIndex.textColor = .customColor(.customGray)
            quizIndex.font = .customFont(.subContent)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = TodayQuizLayoutValue.CornerRadius.cell
        contentView.layer.borderWidth = TodayQuizLayoutValue.Size.cellBorderWidth
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

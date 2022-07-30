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

    lazy var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    var colorBlurView = UIView()
    var flag: Bool = true
    
    var data: Quiz = Quiz(question: "샘플 문장", type: QuizType.blank, rightAnswer: "정답", wrongAnswer: "오답") {
        didSet {
            quizQuestion.text = makeQuizSentence(quiz: data)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = QuizType1LayoutValue.Cell.cornerLadius
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.customOrange.cgColor
    }
    
    deinit {
        print("Deinit \(self)")
    }
}

extension QuizTypeBlank {
    func applyBlur() {
        if flag {
            self.addSubview(visualEffectView)
            visualEffectView.translatesAutoresizingMaskIntoConstraints = false
            visualEffectView.layer.cornerRadius = TodayQuizLayoutValue.CornerRadius.cell
            visualEffectView.clipsToBounds = true
            visualEffectView.layer.opacity = 0.9
            NSLayoutConstraint.activate([
                visualEffectView.topAnchor.constraint(equalTo: self.topAnchor),
                visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            self.addSubview(colorBlurView)
            colorBlurView.backgroundColor = .customIvory
            colorBlurView.translatesAutoresizingMaskIntoConstraints = false
            colorBlurView.layer.cornerRadius = TodayQuizLayoutValue.CornerRadius.cell
            colorBlurView.clipsToBounds = true
            colorBlurView.layer.opacity = 0.5
            NSLayoutConstraint.activate([
                colorBlurView.topAnchor.constraint(equalTo: self.topAnchor),
                colorBlurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                colorBlurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                colorBlurView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        } else {
            visualEffectView.removeFromSuperview()
            colorBlurView.removeFromSuperview()

        }
    }
    
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

//
//  SolvedQuizType1CollectionViewCell.swift
//  GaNaDa
//
//  Created by Somin Park on 2022/07/26.
//

import UIKit

final class SolvedQuizType1CollectionViewCell: QuizCollectionViewCell {

    static let identifier = "SolvedQuizType1CollectionViewCell"
    @IBOutlet private weak var quizIndexLabel: UILabel!
    @IBOutlet private weak var quizContent: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawSolvedQuizeType1CellUI()
    }

}

extension SolvedQuizType1CollectionViewCell {
    func drawSolvedQuizeType1CellUI() {
        quizIndexLabel.textColor = .customColor(.customGray)
        quizIndexLabel.font = .customFont(.subContent)
        quizContent.font = .customFont(.content)
    }
    
    func setBlankQuiz (indexPath: IndexPath, quiz: Quiz) {
        quizIndexLabel.text = "문제 \((quiz.quizID - 1) % 3 + 1)"
        quizContent.text = makeQuestion(question: quiz.question, rightAnswer: quiz.rightAnswer, wrongAnswer: quiz.wrongAnswer)
        quizContent.setTargetStringUI(rightAnswer: quiz.rightAnswer, wrongAnswer: quiz.wrongAnswer)
        if quiz.stateRawValue == 1 {
            markImage.image = .init(named: "right")
        }else {
            markImage.image = .init(named: "wrong")
        }
    }
    
    func makeQuestion(question: String, rightAnswer: String, wrongAnswer: String) -> String {
        return question.replacingOccurrences(of: "*", with: "( \(rightAnswer) / \(wrongAnswer) )")
    }
}

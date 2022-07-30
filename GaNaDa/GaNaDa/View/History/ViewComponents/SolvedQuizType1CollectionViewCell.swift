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
        //MARK: 임시 레이아웃
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - QuizType2LayoutValue.Padding.cellHoriz * 2),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

extension SolvedQuizType1CollectionViewCell {
    func drawSolvedQuizeType1CellUI() {
        quizIndexLabel.textColor = .customColor(.customGray)
        quizIndexLabel.font = .customFont(.subContent)
        quizContent.font = .customFont(.content) //글자크기 확인
    }
    
    func setBlankQuiz (indexPath: IndexPath) {
        let quiz = HistoryQuiz.preview[indexPath.row]
        quizIndexLabel.text = "문제 \(indexPath.row + 1)"
        quizContent.text = makeQuestion(question: quiz.question, rightAnswer: quiz.rightAnswer, wrongAnswer: quiz.wrongAnswer)
        quizContent.setTargetStringFont(targetString: quiz.rightAnswer, font: .customFont(.customAnswer))
        quizContent.setTargetStringFont(targetString: quiz.wrongAnswer, font: .customFont(.customAnswer))
        quizContent.setTargetStringColor(targetString: quiz.rightAnswer, color: .customOrange)
        quizContent.setTargetStringStrikeThrough(targetString: quiz.wrongAnswer, color: .black)
        if quiz.status == 1 {
            markImage.image = .init(named: "right")
        }else {
            markImage.image = .init(named: "wrong")
        }
    }
    
    func makeQuestion(question: String, rightAnswer: String, wrongAnswer: String) -> String {
        return question.replacingOccurrences(of: "*", with: "( \(rightAnswer) / \(wrongAnswer) )")
    }
}

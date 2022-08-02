//
//  SolvedQuizType2CollectionViewCell.swift
//  GaNaDa
//
//  Created by Somin Park on 2022/07/27.
//

import UIKit

class SolvedQuizType2CollectionViewCell: QuizCollectionViewCell {

    static let identifier = "SolvedQuizType2CollectionViewCell"
    
    @IBOutlet weak var wrongAnswerLabel: UILabel!
    @IBOutlet weak var vsTextLabel: UILabel!
    @IBOutlet weak var rightAnswerLabel: UILabel!
    @IBOutlet weak var quizIndexLabel: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawSolvedQuizeType1CellUI()
    }
}

extension SolvedQuizType2CollectionViewCell {
    func drawSolvedQuizeType1CellUI() {
        quizIndexLabel.textColor = .customColor(.customGray)
        quizIndexLabel.font = .customFont(.subContent)
        rightAnswerLabel.textColor = .customOrange
        rightAnswerLabel.font = .customFont(.customAnswer)
        wrongAnswerLabel.font = .customFont(.customAnswer)
        vsTextLabel.textColor = .customColor(.customGray)
        vsTextLabel.font = .customFont(.content)
        vsTextLabel.text = "vs"
    }
    
    func setChoiceQuiz(indexPath: IndexPath, quiz: Quiz) {
        quizIndexLabel.text = "문제 \((quiz.quizID - 1) % 3 + 1)"
        rightAnswerLabel.text = quiz.rightAnswer
        wrongAnswerLabel.text = quiz.wrongAnswer
        wrongAnswerLabel.setTargetStringStrikeThrough(targetString: quiz.wrongAnswer, color: .black)
        if quiz.stateRawValue == 1 {
            markImage.image = .init(named: "right")
        }else {
            markImage.image = .init(named: "wrong")
        }
    }
}

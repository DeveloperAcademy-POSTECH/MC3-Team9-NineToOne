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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawSolvedQuizeType1CellUI()
    }
}

extension SolvedQuizType2CollectionViewCell {
    func drawSolvedQuizeType1CellUI() {
        quizIndexLabel.textColor = UIColor.customColor(.customGray)
        quizIndexLabel.font = UIFont.customFont(.subContent)
        rightAnswerLabel.textColor = UIColor.systemOrange //custom color로 교체
        rightAnswerLabel.font = UIFont.customFont(.customAnswer)
        wrongAnswerLabel.font = UIFont.customFont(.customAnswer)
        vsTextLabel.textColor = UIColor.customColor(.customGray)
        vsTextLabel.font = UIFont.customFont(.content)
    }
}

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawSolvedQuizeType1CellUI()
    }

}

private extension SolvedQuizType1CollectionViewCell {
    func drawSolvedQuizeType1CellUI() {
        quizIndexLabel.textColor = UIColor.customColor(.customGray)
        quizIndexLabel.font = UIFont.customFont(.subContent)
        quizContent.font = UIFont.customFont(.content) //글자크기 확인
    }
}

//
//  SolvedQuizType1CollectionViewCell.swift
//  GaNaDa
//
//  Created by Somin Park on 2022/07/26.
//

import UIKit

struct SolvedQuizCellUIValue {
    enum CornerRadius {
        static let solvedQuizCell = 16.0
    }
//    struct shadow {
//        static let boaderWidth = 1
//        static let Offset = CGSize(width: 0, height: 4)
//        static let Opacity = 0.1
//    }
}

final class SolvedQuizType1CollectionViewCell: UICollectionViewCell {

    static let identifier = "SolvedQuizType1CollectionViewCell"
    @IBOutlet private weak var quizIndexLabel: UILabel!
    @IBOutlet private weak var quizContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawSolvedCellUI()
    }

}

extension SolvedQuizType1CollectionViewCell {
    func drawSolvedCellUI() {
        contentView.layer.applyShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 25, spread: 0)
        contentView.layer.cornerRadius = SolvedQuizCellUIValue.CornerRadius.solvedQuizCell
    }
}

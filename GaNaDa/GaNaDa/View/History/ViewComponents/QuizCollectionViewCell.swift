//
//  QuizCollectionViewCell.swift
//  GaNaDa
//
//  Created by Somin Park on 2022/07/27.
//

import UIKit

struct QuizCellUIValue {
    enum CornerRadius {
        static let quizCell = 16.0
    }
}

class QuizCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
}

private extension QuizCollectionViewCell {
    func setCellUI() {
        contentView.layer.applyShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 20, spread: 0)
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.customOrange.cgColor
        contentView.layer.cornerRadius = QuizCellUIValue.CornerRadius.quizCell
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}

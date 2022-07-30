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
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setCellUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }

    
}

private extension QuizCollectionViewCell {
    func setCellUI() {
        contentView.layer.applyShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 5, blur: 4, spread: 0)
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.orange.cgColor //커스텀컬러로 교체
        contentView.layer.cornerRadius = QuizCellUIValue.CornerRadius.quizCell
    }
}

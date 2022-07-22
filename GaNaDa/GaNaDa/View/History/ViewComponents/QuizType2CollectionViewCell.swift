//
//  QuizType2CollectionViewCell.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/22.
//

import UIKit

final class QuizType2CollectionViewCell: UICollectionViewCell {
    
    private lazy var quizContentLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
    
    private func configureCell() {
        quizContentLabel.text = "다음 중 맞는 것을 고르세요"
        quizContentLabel.font = UIFont.systemFont(ofSize: 14)
        quizContentLabel.textColor = .black
        quizContentLabel.textAlignment = .left
        self.contentView.addSubview(quizContentLabel)
    }
}

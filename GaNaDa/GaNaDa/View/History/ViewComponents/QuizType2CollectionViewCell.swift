//
//  QuizType2CollectionViewCell.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/22.
//

import UIKit

final class QuizType2CollectionViewCell: UICollectionViewCell {
    
    private lazy var contentNumberLabel = UILabel()
    private lazy var quizContentLabel = UILabel()
    private lazy var contentAnswerAButton = UIButton()
    private lazy var contentAnswerBButton = UIButton()
    
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "Error ID"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureComponents(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
    
    private func configureComponents(frame: CGRect) {
        configureContentView(frame: frame)
        configureContentNumberLabel()
        configureContentLabel()
        configurecontentAnswerAButton()
        configurecontentAnswerBButton()
    }
    
    private func configureContentView(frame: CGRect) {
        self.contentView.layer.cornerRadius = 16.0
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
        ])
    }
    
    private func configureContentNumberLabel() {
        self.contentView.addSubview(contentNumberLabel)
        contentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        contentNumberLabel.text = "문제 2"
        contentNumberLabel.font = UIFont.systemFont(ofSize: 14)
        contentNumberLabel.textColor = .black
        contentNumberLabel.textAlignment = .left
        contentNumberLabel.sizeToFit()
        NSLayoutConstraint.activate([
            contentNumberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 22),
            contentNumberLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 24)
        ])
    }
    
    private func configureContentLabel() {
        self.contentView.addSubview(quizContentLabel)
        quizContentLabel.translatesAutoresizingMaskIntoConstraints = false
        quizContentLabel.text = "다음 중 맞는 것을 고르세요"
        quizContentLabel.font = UIFont.systemFont(ofSize: 14)
        quizContentLabel.textColor = .black
        quizContentLabel.textAlignment = .left
        quizContentLabel.sizeToFit()
        NSLayoutConstraint.activate([
            quizContentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 22),
            quizContentLabel.leftAnchor.constraint(equalTo: self.contentNumberLabel.rightAnchor, constant: 12)
        ])
    }
    
    private func configurecontentAnswerAButton() {
        self.contentView.addSubview(contentAnswerAButton)
        contentAnswerAButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentAnswerAButton.topAnchor.constraint(equalTo: self.contentNumberLabel.bottomAnchor, constant: 30),
            contentAnswerAButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 14),
            contentAnswerAButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -14),
            contentAnswerAButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        contentAnswerAButton.backgroundColor = .blue
    }
    
    private func configurecontentAnswerBButton() {
        self.contentView.addSubview(contentAnswerBButton)
        contentAnswerBButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentAnswerBButton.topAnchor.constraint(equalTo: self.contentAnswerAButton.bottomAnchor, constant: 8),
            contentAnswerBButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 14),
            contentAnswerBButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -14),
            contentAnswerBButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -27),
            contentAnswerBButton.widthAnchor.constraint(equalToConstant: 325),
            contentAnswerBButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        contentAnswerBButton.backgroundColor = .blue
    }
}

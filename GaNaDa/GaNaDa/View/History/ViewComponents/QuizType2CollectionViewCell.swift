//
//  QuizType2CollectionViewCell.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/22.
//

import UIKit

struct QuizType2LayoutValue {
    enum Padding {
        static let cellHoriz: CGFloat = 18.0
        static let textTop: CGFloat = 22.0
        static let textLeft: CGFloat = 24.0
        static let rightFromContentNumber: CGFloat = 12.0
        static let topFromContentText: CGFloat = 30.0
        static let buttonHoriz: CGFloat = 14.0
        static let betweenButton: CGFloat = 8.0
        static let buttonFromBottom: CGFloat = 24.0
    }
    
    enum CornerRadius {
        static let answerButton = 9.8
    }
    
    struct Size {
        enum Height {
            static let answerButton: CGFloat = 34.0
        }
    }
}

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
}

// MARK: - Cell autolayout
private extension QuizType2CollectionViewCell {
    func configureContentView(frame: CGRect) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - QuizType2LayoutValue.Padding.cellHoriz * 2),
            self.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func configureContentNumberLabel() {
        self.contentView.addSubview(contentNumberLabel)
        contentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        contentNumberLabel.text = "문제 2"
        contentNumberLabel.font = UIFont.systemFont(ofSize: 14) // TODO: - merge 이후 extension 이용하여 수정 예정
        contentNumberLabel.textColor = .black // TODO: - merge 이후 extension 이용하여 수정 예정
        contentNumberLabel.textAlignment = .left
        contentNumberLabel.sizeToFit()
        NSLayoutConstraint.activate([
            contentNumberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: QuizType2LayoutValue.Padding.textTop),
            contentNumberLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: QuizType2LayoutValue.Padding.textLeft)
        ])
    }
    
    func configureContentLabel() {
        self.contentView.addSubview(quizContentLabel)
        quizContentLabel.translatesAutoresizingMaskIntoConstraints = false
        quizContentLabel.text = "다음 중 맞는 것을 고르세요"
        quizContentLabel.font = UIFont.systemFont(ofSize: 14) // TODO: - merge 이후 extension 이용하여 수정 예정
        quizContentLabel.textColor = .black // TODO: - merge 이후 extension 이용하여 수정 예정
        quizContentLabel.textAlignment = .left
        quizContentLabel.sizeToFit()
        NSLayoutConstraint.activate([
            quizContentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: QuizType2LayoutValue.Padding.textTop),
            quizContentLabel.leftAnchor.constraint(equalTo: self.contentNumberLabel.rightAnchor, constant: QuizType2LayoutValue.Padding.rightFromContentNumber)
        ])
    }
    
    func configurecontentAnswerAButton() {
        self.contentView.addSubview(contentAnswerAButton)
        contentAnswerAButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentAnswerAButton.topAnchor.constraint(equalTo: self.contentNumberLabel.bottomAnchor, constant: QuizType2LayoutValue.Padding.topFromContentText),
            contentAnswerAButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerAButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -1 * QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerAButton.heightAnchor.constraint(equalToConstant: QuizType2LayoutValue.Size.Height.answerButton)
        ])
        contentAnswerAButton.backgroundColor = .blue
        contentAnswerAButton.layer.cornerRadius = QuizType2LayoutValue.CornerRadius.answerButton
    }
    
    func configurecontentAnswerBButton() {
        self.contentView.addSubview(contentAnswerBButton)
        contentAnswerBButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentAnswerBButton.topAnchor.constraint(equalTo: self.contentAnswerAButton.bottomAnchor, constant: QuizType2LayoutValue.Padding.betweenButton),
            contentAnswerBButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerBButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -1 * QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerBButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -1 * QuizType2LayoutValue.Padding.buttonFromBottom),
            contentAnswerBButton.heightAnchor.constraint(equalToConstant: QuizType2LayoutValue.Size.Height.answerButton)
        ])
        contentAnswerBButton.backgroundColor = .blue
        contentAnswerBButton.layer.cornerRadius = QuizType2LayoutValue.CornerRadius.answerButton
    }
}

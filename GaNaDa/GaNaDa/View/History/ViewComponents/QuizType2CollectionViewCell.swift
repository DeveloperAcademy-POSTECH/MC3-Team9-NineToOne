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
        static let labelTop: CGFloat = 59
        static let rightFromContentNumber: CGFloat = 12.0
        static let topFromContentText: CGFloat = 30.0
        static let buttonHoriz: CGFloat = 14.0
        static let betweenButton: CGFloat = 8.0
        static let buttonFromBottom: CGFloat = 24.0
    }
    
    enum CornerRadius {
        static let cell = 16.0
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
    private lazy var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    static var id: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "Error ID"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
    
    private func configureComponents() {
        configureContentView()
        configureContentNumberLabel()
        configureContentLabel()
    }
    
    //MARK: quiz: HistoryQuiz -> Quiz로 수정해야함
    func setQuiz(quizNum: Int, quiz: Quiz) {
        contentNumberLabel.text = "문제 \(quizNum)"
        quizContentLabel.text = quiz.isLeftAnswer ? "\(quiz.rightAnswer) vs \(quiz.wrongAnswer)" : "\(quiz.wrongAnswer) vs \(quiz.rightAnswer)"
    }
}

// MARK: - Cell autolayout
private extension QuizType2CollectionViewCell {
    func configureContentView() {
//        self.backgroundColor = .customColor(.customLightgray)
        self.layer.cornerRadius = QuizType2LayoutValue.CornerRadius.cell
        self.layer.borderWidth = TodayQuizLayoutValue.Size.cellBorderWidth
        self.layer.borderColor = UIColor.customOrange.cgColor
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - QuizType2LayoutValue.Padding.cellHoriz * 2),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configureContentNumberLabel() {
        self.contentView.addSubview(contentNumberLabel)
        contentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        contentNumberLabel.text = "문제 N"
        contentNumberLabel.font = .customFont(.subContent)
        contentNumberLabel.textColor = .customColor(.customGray)
        contentNumberLabel.textAlignment = .left
        contentNumberLabel.sizeToFit()
        NSLayoutConstraint.activate([
            contentNumberLabel.heightAnchor.constraint(equalToConstant: 20),
            contentNumberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: QuizType2LayoutValue.Padding.textTop),
            contentNumberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: QuizType2LayoutValue.Padding.textLeft)
        ])
    }
    
    func configureContentLabel() {
        self.contentView.addSubview(quizContentLabel)
        quizContentLabel.translatesAutoresizingMaskIntoConstraints = false
        quizContentLabel.text = "다음 중 맞는 것을 고르세요"
        quizContentLabel.font = .customFont(.content)
        quizContentLabel.textAlignment = .left
        quizContentLabel.sizeToFit()
        NSLayoutConstraint.activate([
            quizContentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: QuizType2LayoutValue.Padding.labelTop),
            quizContentLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
}

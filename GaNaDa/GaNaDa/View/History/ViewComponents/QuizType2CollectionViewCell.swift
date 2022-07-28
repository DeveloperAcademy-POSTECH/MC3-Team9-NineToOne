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
        configurecontentAnswerAButton()
        configurecontentAnswerBButton()
    }
    
    func setQuiz(quizNum: Int, quiz: Quiz) {
        contentNumberLabel.text = "문제 \(quizNum)"
        quizContentLabel.text = quiz.question
        contentAnswerAButton.setTitle(quiz.rightAnswer, for: .normal)
        contentAnswerBButton.setTitle(quiz.wrongAnswer, for: .normal)
        //TODO: - if 문제가 아직 열리지 않았으면!!
        if quizNum % 4 == 0 { configureBlurView(flag: true) } else { configureBlurView(flag: false) }
    }
}

// MARK: - Cell autolayout
private extension QuizType2CollectionViewCell {
    func configureContentView() {
        self.backgroundColor = .customColor(.customLightgray)
        self.layer.cornerRadius = QuizType2LayoutValue.CornerRadius.cell
        self.layer.applyFigmaShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 25, spread: 0)
        self.clipsToBounds = false
        self.layer.masksToBounds = false
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
        contentNumberLabel.font = UIFont.customFont(.content)
        contentNumberLabel.textColor = UIColor.customColor(.customGray)
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
        quizContentLabel.font = UIFont.customFont(.content)
        quizContentLabel.textColor = UIColor.customColor(.customGray)
        quizContentLabel.textAlignment = .left
        quizContentLabel.sizeToFit()
        NSLayoutConstraint.activate([
            quizContentLabel.heightAnchor.constraint(equalToConstant: 20),
            quizContentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: QuizType2LayoutValue.Padding.textTop),
            quizContentLabel.leadingAnchor.constraint(equalTo: self.contentNumberLabel.trailingAnchor, constant: QuizType2LayoutValue.Padding.rightFromContentNumber)
        ])
    }
    
    func configurecontentAnswerAButton() {
        self.contentView.addSubview(contentAnswerAButton)
        contentAnswerAButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentAnswerAButton.topAnchor.constraint(equalTo: self.contentNumberLabel.bottomAnchor, constant: QuizType2LayoutValue.Padding.topFromContentText),
            contentAnswerAButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerAButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -1 * QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerAButton.heightAnchor.constraint(equalToConstant: QuizType2LayoutValue.Size.Height.answerButton)
        ])
        contentAnswerAButton.backgroundColor = .customColor(.subBrand)
        contentAnswerAButton.layer.cornerRadius = QuizType2LayoutValue.CornerRadius.answerButton
        contentAnswerAButton.titleLabel?.font = .customFont(.subContent)
        contentAnswerAButton.setTitleColor(.white, for: .normal)
    }
    
    func configurecontentAnswerBButton() {
        self.contentView.addSubview(contentAnswerBButton)
        contentAnswerBButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentAnswerBButton.topAnchor.constraint(equalTo: self.contentAnswerAButton.bottomAnchor, constant: QuizType2LayoutValue.Padding.betweenButton),
            contentAnswerBButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerBButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -1 * QuizType2LayoutValue.Padding.buttonHoriz),
            contentAnswerBButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -1 * QuizType2LayoutValue.Padding.buttonFromBottom),
            contentAnswerBButton.heightAnchor.constraint(equalToConstant: QuizType2LayoutValue.Size.Height.answerButton)
        ])
        contentAnswerBButton.backgroundColor = .customColor(.subBrand)
        contentAnswerBButton.layer.cornerRadius = QuizType2LayoutValue.CornerRadius.answerButton
        contentAnswerBButton.titleLabel?.font = .customFont(.subContent)
        contentAnswerBButton.setTitleColor(.white, for: .normal)
    }
    
    func configureBlurView(flag: Bool) {
        if flag {
            self.addSubview(visualEffectView)
            visualEffectView.translatesAutoresizingMaskIntoConstraints = false
            visualEffectView.layer.cornerRadius = QuizType2LayoutValue.CornerRadius.cell
            visualEffectView.clipsToBounds = true
            visualEffectView.layer.opacity = 0.9
            NSLayoutConstraint.activate([
                visualEffectView.topAnchor.constraint(equalTo: self.topAnchor),
                visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        } else {
            visualEffectView.removeFromSuperview()
        }
    }
}

// REFERENCE: - https://baechukim.tistory.com/112
extension CALayer {
    func applyFigmaShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / UIScreen.main.scale
        if spread == 0 {
            shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

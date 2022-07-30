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
    @IBOutlet weak var markImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawSolvedQuizeType1CellUI()
        //MARK: 임시 레이아웃
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - QuizType2LayoutValue.Padding.cellHoriz * 2),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension SolvedQuizType2CollectionViewCell {
    func drawSolvedQuizeType1CellUI() {
        quizIndexLabel.textColor = .customColor(.customGray)
        quizIndexLabel.font = .customFont(.subContent)
        rightAnswerLabel.textColor = .customOrange
        rightAnswerLabel.font = .customFont(.customAnswer)
        wrongAnswerLabel.font = .customFont(.customAnswer)
        vsTextLabel.textColor = .customColor(.customGray)
        vsTextLabel.font = .customFont(.content)
    }
    
    func setChoiceQuiz(indexPath: IndexPath) {
        let quiz = HistoryQuiz.preview[indexPath.row]
        quizIndexLabel.text = "\(indexPath.row + 1)"
        rightAnswerLabel.text = quiz.rightAnswer
        wrongAnswerLabel.text = quiz.wrongAnswer
        wrongAnswerLabel.setTargetStringStrikeThrough(targetString: quiz.wrongAnswer, color: .black)
        if quiz.status == 1 {
            markImage.image = .init(named: "right")
        }else {
            markImage.image = .init(named: "wrong")
        }
    }
}

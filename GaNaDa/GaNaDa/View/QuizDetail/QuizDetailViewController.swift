//
//  QuizDetailViewController.swift
//  GaNaDa
//
//  Created by 김민택 on 2022/07/28.
//

import UIKit

class QuizDetailViewController: UIViewController {
    private var quiz: Quiz!
    private var isSolved: Bool = false
    
    // Choice
    @IBOutlet weak var choiceQuizStack: UIStackView!
    @IBOutlet weak var rightAnswer: UILabel!
    @IBOutlet weak var leftAnswer: UILabel!
    
    // Blank
    @IBOutlet weak var blankQuizStack: UIStackView!
    @IBOutlet weak var leadingQuizLabel: UILabel!
    @IBOutlet weak var emptyQuizLabel: UILabel!
    @IBOutlet weak var trailingQuizLabel: UILabel!
    
    @IBOutlet weak var quizSection: UIView!
    @IBOutlet weak var quizNum: UILabel!
    @IBOutlet weak var quizDetail: UILabel!
    @IBOutlet weak var quizDetailExample: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setNavigationBar(navigationTitle: "해설", popGesture: isSolved, hidesBackButton: !isSolved)
        fetchQuizDetail()
    }
    
    func configureView() {
        quizSection.layer.borderColor = UIColor.customOrange.cgColor
        quizSection.layer.borderWidth = 1
        quizSection.layer.applyShadow(color: UIColor.darkGray, alpha: 0.05, x: 0, y: 4, blur: 16, spread: 0)
        quizSection.clipsToBounds = false
//        quizSection.layer.shadowRadius = 10
//        quizSection.layer.shadowPath
//        quizSection.layer.shadowColor
//        quizSection.layer.shadowOpacity
//        quizSection.layer.shadowOffset
        
        closeButton.layer.cornerRadius = 16
        closeButton.clipsToBounds = true
    }
    
    func fetchQuizDetail() {
        quizNum.text = "문제 \(quiz.quizID + 1)"
        quizDetail.text = quiz.description
        
        choiceQuizStack.isHidden = (quiz.quizType == .blank)
        blankQuizStack.isHidden = (quiz.quizType == .choice)
        
        quiz.quizType == .blank ? setForBlankType() : setForChoiceType()
        
        var example = quiz.example.reduce("") { result, example in
            return result + example + "\n"
        }
        example.removeLast()
        quizDetailExample.text = example
    }
    
    private func setForBlankType() {
        leadingQuizLabel.text = (quiz.question.components(separatedBy: "*").first ?? "") + "("
        emptyQuizLabel.text = " \(quiz.rightAnswer)"
        trailingQuizLabel.text = " )" + (quiz.question.components(separatedBy: "*").last ?? "")
    }
    
    private func setForChoiceType() {
        leftAnswer.text = quiz.isLeftAnswer ? quiz.rightAnswer : quiz.wrongAnswer
        rightAnswer.text = quiz.isLeftAnswer ? quiz.wrongAnswer : quiz.rightAnswer
        
        setSelectAnswerFont(label: (quiz.isLeftAnswer) ? leftAnswer : rightAnswer)
    }
    
    private func setSelectAnswerFont(label: UILabel) {
        label.font = UIFont(name: "GowunBatang-Bold", size: 24)
        label.textColor = UIColor.point
    }
    
    // MARK: - Methods
    public func prepareData(quiz: Quiz = .previewChoice, isSolved: Bool = false) {
        self.quiz = quiz
        self.isSolved = isSolved
    }
    
    @IBAction func tapToHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

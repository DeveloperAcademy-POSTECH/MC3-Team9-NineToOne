//
//  QuizViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/27.
//

import UIKit

final class QuizViewController: UIViewController {
    // MARK: - Properties
    private var quiz: Quiz!
    private var selectedAnswer: String = "" {
        willSet {
            answerButton.isEnabled = !newValue.isEmpty
            answerButton.backgroundColor = newValue.isEmpty ? .init(hex: 0xFEECC3) : .init(hex: 0xFFAD3C)
            if newValue != "" {
                emptyQuizLabel.text = " \(newValue)"
            }
            emptyQuizLabel.textColor = (newValue == "") ? .clear : .init(hex: 0xFFAD3C)
        }
    }
    
    // MARK: - Methods
    public func prepareData(quiz: Quiz = .previewChoice) {
        self.quiz = quiz
    }
    
    private func touchAnswerButton(_ touchButton: UIButton, other: UIButton) {
        let answer = touchButton.title(for: .normal) ?? ""
        touchButton.backgroundColor = (selectedAnswer == answer) ? .init(hex: 0xFEECC3) : .init(hex: 0xFFAD3C)
        if (selectedAnswer != answer) {
            other.backgroundColor = .init(hex: 0xFEECC3)
        }
        selectedAnswer = (selectedAnswer == answer) ? "" : answer
    }
    
    private func loadData() {
        blankQuizGuideLabel.isHidden = (quiz.quizType == .choice)
        blankQuizStack.isHidden = (quiz.quizType == .choice)
        
        quizLabel.isHidden = (quiz.quizType == .blank)
        
        if quiz.quizType == .blank {
            leadingQuizLabel.text = (quiz.question.components(separatedBy: "*").first ?? "") + "("
            emptyQuizLabel.text = " \((quiz.rightAnswer.count > quiz.wrongAnswer.count) ? quiz.rightAnswer : quiz.wrongAnswer)"
            
            trailingQuizLabel.text = " )" + (quiz.question.components(separatedBy: "*").last ?? "")
        }
        
        // 해쉬 홀수면 왼쪽, 짝수면 오른쪽
//        print(String(quiz.quizID).hashValue)
        firstAnswerButton.setTitle(quiz.quizID.hashValue.isOdd ? quiz.rightAnswer : quiz.wrongAnswer, for: .normal)
        secondAnswerButton.setTitle(quiz.quizID.hashValue.isOdd ? quiz.wrongAnswer : quiz.rightAnswer, for: .normal)
    }
    
    // MARK: - IBOutlets
    // Choice
    @IBOutlet weak var quizLabel: UILabel!
    
    // Blank
    @IBOutlet weak var blankQuizGuideLabel: UILabel!
    @IBOutlet weak var blankQuizStack: UIStackView!
    @IBOutlet weak var leadingQuizLabel: UILabel!
    @IBOutlet weak var emptyQuizLabel: UILabel!
    @IBOutlet weak var trailingQuizLabel: UILabel!
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var answerButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func touchFirstAnswer(_ sender: UIButton) {
        touchAnswerButton(sender, other: secondAnswerButton)
    }
    
    @IBAction func touchSecondAnswer(_ sender: UIButton) {
        touchAnswerButton(sender, other: firstAnswerButton)
    }
    
    @IBAction func touchShowAnswer(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let quizAnswerViewController = storyboard.instantiateViewController(withIdentifier: "QuizAnswerView") as? QuizAnswerViewController {
            quiz.stateRawValue = (selectedAnswer == quiz.rightAnswer) ? 1 : 2
            quizAnswerViewController.prepareView(quiz: quiz)
            navigationController?.pushViewController(quizAnswerViewController, animated: true)
        }
    }
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quiz = .previewChoice // [Quiz.previewBlank, Quiz.previewChoice].randomElement()
        setNavigationBar(navigationTitle: "문제")
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emptyQuizLabel.widthAnchor.constraint(equalToConstant: emptyQuizLabel.frame.width).isActive = true
    }
}


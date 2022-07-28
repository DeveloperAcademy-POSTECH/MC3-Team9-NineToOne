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
        }
    }
    
    // MARK: - Methods
    public func prepareData(quiz: Quiz = .preview) {
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
        blankQuizGuideLabel.isHidden = (quiz.type == .choice)
        quizLabel.text = quiz.question
        firstAnswerButton.setTitle(quiz.rightAnswer, for: .normal)
        secondAnswerButton.setTitle(quiz.wrongAnswer, for: .normal)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var blankQuizGuideLabel: UILabel!
    @IBOutlet weak var quizLabel: UILabel!
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
        self.quiz = .preview
        setNavigationBar(navigationTitle: "문제")
        loadData()
    }
}

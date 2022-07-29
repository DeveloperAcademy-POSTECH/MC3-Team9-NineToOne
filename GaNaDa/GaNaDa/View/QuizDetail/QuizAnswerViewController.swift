//
//  QuizAnswerViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/27.
//

import UIKit
import Lottie

final class QuizAnswerViewController: UIViewController {
    // MARK: - Properties
    var quiz: Quiz!
    
    // MARK: - Methods
    func prepareView(quiz: Quiz) {
        self.quiz = quiz
    }
    
    private func loadData() {
        choiceQuizStack.isHidden = (quiz.type == .blank)
        blankQuizStack.isHidden = (quiz.type == .choice)
        
        quiz.type == .blank ? setForBlankType() : setForChoiceType()
        
//        resultImageView.image = UIImage(systemName: "house")
        resultGuideLabel.text = (quiz.quizState == .right) ? "정답이에요.\n경험치 + \(quiz.quizID)" : "오답이에요.\n해설을 확인해보시겠어요?"
        
        
//        resultImageView.image = UIImage(named: <#T##String#>)
    }
    
    private func setForBlankType() {
        leadingQuizLabel.text = (quiz.question.components(separatedBy: "*").first ?? "") + "("
        if quiz.quizState == .right {
            emptyQuizLabel.text = " \(quiz.rightAnswer)"
        } else {
            let answer = " \(quiz.wrongAnswer)"
            let attributedStr = NSMutableAttributedString(string: answer)
            attributedStr.addAttribute(.strikethroughStyle,
                                       value: 1,
                                       range: ( answer as NSString).range(of: quiz.wrongAnswer))
            emptyQuizLabel.attributedText = attributedStr
        }
        
        trailingQuizLabel.text = " )" + (quiz.question.components(separatedBy: "*").last ?? "")
    }
    
    private func setForChoiceType() {
        leftAnswer.text = quiz.quizID.hashValue.isOdd ? quiz.rightAnswer : quiz.wrongAnswer
        rightAnswer.text = quiz.quizID.hashValue.isOdd ? quiz.wrongAnswer : quiz.rightAnswer
        
        quiz.quizState == .right
        ? setSelectAnswerFont(label: (leftAnswer.text == quiz.rightAnswer) ? leftAnswer : rightAnswer,
                              strikethroughStyle: false)
        : setSelectAnswerFont(label: (leftAnswer.text == quiz.wrongAnswer) ? leftAnswer : rightAnswer,
                              strikethroughStyle: true)
    }
    
    private func setSelectAnswerFont(label: UILabel, strikethroughStyle: Bool) {
        label.font = UIFont(name: "GowunBatang-Bold", size: 24)
        label.textColor = UIColor.point
        if strikethroughStyle {
            let attributedStr = NSMutableAttributedString(string: quiz.wrongAnswer)
            attributedStr.addAttribute(.strikethroughStyle,
                                       value: 1,
                                       range: ( quiz.wrongAnswer as NSString).range(of: quiz.wrongAnswer))
            label.attributedText = attributedStr
        }
    }
    
    private func configureLottievView() {
        lottieView.isHidden = false
        lottieView.loopMode = .loop
        lottieView.layer.opacity = 0.5
        lottieView.play()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var lottieView: AnimationView!
    
    // Choice
    @IBOutlet weak var choiceQuizStack: UIStackView!
    @IBOutlet weak var rightAnswer: UILabel!
    @IBOutlet weak var leftAnswer: UILabel!
    
    // Blank
    @IBOutlet weak var blankQuizStack: UIStackView!
    @IBOutlet weak var leadingQuizLabel: UILabel!
    @IBOutlet weak var emptyQuizLabel: UILabel!
    @IBOutlet weak var trailingQuizLabel: UILabel!
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultGuideLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func goToQuizDescriptView(_ sender: UIButton) {
        
    }
    
    @IBAction func goToMainView(_ sender: UIButton) {
        
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationTitle: "문제")
        loadData()
        if quiz.quizState == .right {
            configureLottievView()
        }
    }
}

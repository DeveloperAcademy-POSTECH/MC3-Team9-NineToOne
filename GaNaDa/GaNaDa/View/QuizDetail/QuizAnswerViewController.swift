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
    func prepareData(quiz: Quiz) {
        self.quiz = quiz
    }
    
    private func loadData() {
        choiceQuizStack.isHidden = (quiz.quizType == .blank)
        blankQuizStack.isHidden = (quiz.quizType == .choice)
        
        quiz.quizType == .blank ? setForBlankType() : setForChoiceType()
        
        // TODO: 실제 USER 정보로 바꿔야함
        resultImageView.image = LevelCase.level(exp: User.preview.exp).levelImage
        
        // TODO: 실제 USER 정보로 바꿔야함
        resultGuideLabel.text = (quiz.quizState == .right) ? "정답이에요.\n경험치 + 20" : "오답이에요.\n해설을 확인해보시겠어요?"
        if quiz.quizState == .right {
            let userExp = UserDefaults.standard.integer(forKey: "userExp")
            UserDefaults.standard.setValue(userExp + 20, forKey: "userExp")
        }
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
        leftAnswer.text = quiz.isLeftAnswer ? quiz.rightAnswer : quiz.wrongAnswer
        rightAnswer.text = quiz.isLeftAnswer ? quiz.wrongAnswer : quiz.rightAnswer
        
        setSelectAnswerFont(label: (quiz.isLeftAnswer) == (quiz.quizState == .right) ? leftAnswer : rightAnswer,
                              strikethroughStyle: quiz.quizState == .wrong)
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
    
    private func configureLottieView() {
        lottieView.isHidden = false
        lottieView.loopMode = .loop
        lottieView.layer.opacity = 0.5
        lottieView.play()
    }
    
    private func configureView() {
        homeButton.isHidden = true
        quizDetailButton.backgroundColor = .customOrange
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
    
    @IBOutlet weak var quizDetailButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func goToQuizDescriptView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let quizDetailViewController = storyboard.instantiateViewController(withIdentifier: "QuizDetailView") as? QuizDetailViewController {
            quizDetailViewController.prepareData(quiz: quiz)
            navigationController?.pushViewController(quizDetailViewController, animated: true)
        }
    }
    
    @IBAction func goToMainView(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationTitle: "문제", hidesBackButton: true)
        loadData()
        if quiz.quizState == .right {
            configureLottieView()
        } else {
            configureView()
        }
    }
}

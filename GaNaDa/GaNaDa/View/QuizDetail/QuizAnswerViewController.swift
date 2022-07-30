//
//  QuizAnswerViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/27.
//

import UIKit
import WebKit

final class QuizAnswerViewController: UIViewController {
    // MARK: - Properties
    var quiz: Quiz!
    
    // MARK: - Methods
    func prepareView(quiz: Quiz) {
        self.quiz = quiz
    }
    
    private func loadData() {
        choiceQuizStack.isHidden = (quiz.quizType == .blank)
        blankQuizStack.isHidden = (quiz.quizType == .choice)
        
        quiz.quizType == .blank ? setForBlankType() : setForChoiceType()
        
        resultImageView.image = UIImage(systemName: "house")
        resultGuideLabel.text = (quiz.quizState == .right) ? "정답이에요.\n경험치 + \(quiz.quizID)" : "오답이에요.\n해설을 확인해보시겠어요?"
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
        label.textColor = .init(hex: 0xED6E2D)
        if strikethroughStyle {
            let attributedStr = NSMutableAttributedString(string: quiz.wrongAnswer)
            attributedStr.addAttribute(.strikethroughStyle,
                                       value: 1,
                                       range: ( quiz.wrongAnswer as NSString).range(of: quiz.wrongAnswer))
            label.attributedText = attributedStr
        }
    }
    
    private func configureLottievView() {
        let fileName = "fireWork"
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "gif") else {
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        
        lottieWebView.load(data,
                           mimeType: "image/gif",
                           characterEncodingName: "UTF-8",
                           baseURL: url.deletingLastPathComponent())
        lottieWebView.scrollView.isScrollEnabled = false
        lottieWebView.scrollView.isUserInteractionEnabled = false
        //        lottieWebView.transform =  CGAffineTransform(rotationAngle: 90 * .pi / 180)
        lottieWebView.isHidden = false
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var lottieWebView: WKWebView!
    
    //    @IBOutlet weak var quizLabel: UILabel!
    
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

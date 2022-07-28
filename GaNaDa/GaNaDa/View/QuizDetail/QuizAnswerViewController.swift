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
    
    // 미완성 코드
    func configureLottievView() {
        let animationView = AnimationView()
        let animation = Animation.named("Firework")
        animationView.animation = animation
        view.addSubview(animationView)
//        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = view.bounds
//        NSLayoutConstraint.activate([
//            animationView.widthAnchor.constraint(equalTo: lottieView.widthAnchor, multiplier: 0.7),
//            animationView.heightAnchor.constraint(equalTo: lottieView.heightAnchor, multiplier: 0.7),
//            animationView.centerXAnchor.constraint(equalTo: lottieView.centerXAnchor),
//            animationView.centerYAnchor.constraint(equalTo: lottieView.centerYAnchor),
//        ])
//        animationView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        animationView.contentMode = .scaleAspectFit
//        animationView.contentScaleFactor = 0.4
//        animationView.shouldRasterizeWhenIdle = true
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
        animationView.play()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var quizLabel: UILabel!
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
        if quiz.quizState == .rigth {
            configureLottievView()
        }
    }
}

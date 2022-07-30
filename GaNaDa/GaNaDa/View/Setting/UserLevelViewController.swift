//
//  UserLevelViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/30.
//

import UIKit

final class UserLevelViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Methods
    private func loadData() {
        levelImageView.image = LevelCase.level(exp: User.preview.exp).levelImage
        levelLabel.text = LevelCase.level(exp: User.preview.exp).rawValue
        guideLabel.text = "이리오너라"
//        let answer = " \(quiz.wrongAnswer)"
//        let attributedStr = NSMutableAttributedString(string: answer)
//        attributedStr.addAttribute(.strikethroughStyle,
//                                   value: 1,
//                                   range: ( answer as NSString).range(of: quiz.wrongAnswer))
//        emptyQuizLabel.attributedText = attributedStr
    }
    
    func setLevelStackView() {
        for (index, level) in LevelCase.allCases.enumerated() {
            let levelCardView = LevelCardView()
            levelCardView.prepareData(levelCase: level, index: index)
            levelStackView.addArrangedSubview(levelCardView)
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var levelStackView: UIStackView!
    
    // MARK: - IBActions
    
    // MARK: - Delegates And DataSources
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationTitle: "등급", popGesture: true)
        setLevelStackView()
        loadData()
    }
}


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
        let userExp = User.preview.exp
        if userExp < 2100 {
            let guideText = "경험치 +\(100 - (userExp % 100)) 달성 시 \(LevelCase.level(exp: userExp + 100).rawValue) 승격"
            let attributedStr = NSMutableAttributedString(string: guideText)
            attributedStr.addAttribute(.foregroundColor,
                                       value: UIColor.black,
                                       range: (guideText as NSString).range(of: "+\(100 - (userExp % 100))"))
            attributedStr.addAttribute(.foregroundColor,
                                       value: UIColor.black,
                                       range: (guideText as NSString).range(of: "\(LevelCase.level(exp: userExp + 100).rawValue)"))
            guideLabel.attributedText = attributedStr
        } else {
            guideLabel.text = "주상 전하 납시오!"
        }
        
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


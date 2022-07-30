//
//  SettingViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/30.
//

import UIKit

final class SettingViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Methods
    private func loadData() {
        levelImageView.image = LevelCase.level(exp: User.preview.exp).levelImage
        levelLabel.text = LevelCase.level(exp: User.preview.exp).rawValue
        nameLabel.text = "이리오너라"
        
//        levelButton.setImage(UIImage(named: "levelButton"), for: .normal)
//        levelButton.imageView?.contentMode = .scaleAspectFit
//        levelButton.titleLabel?.minimumScaleFactor = 0.1
        
//        let attributedStr = NSMutableAttributedString(string: "")
//        let imageAttachment = NSTextAttachment()
//        imageAttachment.image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGray)
//        attributedStr.append(levelButton.titleLabel?.attributedText ?? NSAttributedString(string: ""))
//        attributedStr.append(NSAttributedString(attachment: imageAttachment))
//        levelButton.titleLabel?.attributedText = attributedStr
//        levelButton.titleLabel?.numberOfLines = 1
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func toggleQuizNotification(_ sender: UISwitch) {
        
    }
    
    // MARK: - Delegates And DataSources
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationTitle: "설정", popGesture: true)
        loadData()
    }
}

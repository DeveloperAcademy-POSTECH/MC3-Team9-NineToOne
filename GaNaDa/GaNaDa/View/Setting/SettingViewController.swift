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
        
        levelLabel.minimumScaleFactor = 0.5
        nameLabel.minimumScaleFactor = 0.5
        levelButton.titleLabel?.minimumScaleFactor = 0.5
//        levelButton.addSubview(UIImageView(image: UIImage(systemName: "chevron.right")))
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

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
        let userExp = UserDefaults.standard.integer(forKey: "userExp")
        levelImageView.image = LevelCase.level(exp: userExp).levelImage
        levelLabel.text = LevelCase.level(exp: userExp).rawValue
        nameLabel.text = UserDefaults.standard.string(forKey: "userName")
        nameLabel.sizeToFit()
        levelLabel.sizeToFit()
        
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

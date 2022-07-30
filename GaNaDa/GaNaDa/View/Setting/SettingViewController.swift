//
//  SettingViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/30.
//

import UIKit

class SettingViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Methods
    func loadData() {
        levelImageView.image = LevelCase.level(exp: User.preview.exp).levelImage
        levelLabel.text = LevelCase.level(exp: User.preview.exp).rawValue
        nameLabel.text = "이리오너라"
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func toggleQuizNotification(_ sender: UISwitch) {
        
    }
    
    // MARK: - Delegates And DataSources
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationTitle: "설정")
        loadData()
    }
}
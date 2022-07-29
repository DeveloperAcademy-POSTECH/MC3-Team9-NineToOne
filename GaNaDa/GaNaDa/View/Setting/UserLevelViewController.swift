//
//  UserLevelViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/30.
//

import UIKit

class UserLevelViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Methods
    
    // MARK: - IBOutlets
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    
    // MARK: - IBActions
    
    // MARK: - Delegates And DataSources
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationTitle: "등급")
    }
}

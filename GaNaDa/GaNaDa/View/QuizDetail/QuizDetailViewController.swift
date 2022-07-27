//
//  QuizDetailViewController.swift
//  GaNaDa
//
//  Created by 김민택 on 2022/07/28.
//

import UIKit

class QuizDetailViewController: UIViewController {
    @IBOutlet weak var quizSection: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizSection.layer.borderColor = UIColor.yellow.cgColor
        quizSection.layer.borderWidth = 1
    }
}

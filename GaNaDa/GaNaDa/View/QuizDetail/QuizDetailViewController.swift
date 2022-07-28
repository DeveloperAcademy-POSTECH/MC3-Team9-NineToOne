//
//  QuizDetailViewController.swift
//  GaNaDa
//
//  Created by 김민택 on 2022/07/28.
//

import UIKit

class QuizDetailViewController: UIViewController {
    @IBOutlet weak var quizSection: UIView!
    @IBOutlet weak var quizNum: UILabel!
    @IBOutlet weak var quizContent: UILabel!
    @IBOutlet weak var quizDetail: UILabel!
    @IBOutlet weak var quizDetailExample: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizSection.layer.borderColor = UIColor.orange.cgColor
        quizSection.layer.borderWidth = 1
        closeButton.layer.cornerRadius = 16
        closeButton.clipsToBounds = true
        
        requestQuizDetail(num: 1, content: "그 사람은 왜 그리 똑똑하( 대 )?", detail: "제시하신 문장들에는 놀라거나 못마땅하게 여기는 뜻을 섞어, 어떤 사실을 주어진 것으로 치고 그 사실에 대한 의문을 나타내는 종결 어미 '-는대', '-대'를 써서, '그 사람 아직도 놀고 먹는대?', '그 사람은 왜 그리 똑똑하대?'와 같이 표현합니다.", example: "- 그사람은 왜 그랬었대?")
    }
    
    func requestQuizDetail(num: Int, content: String, detail: String, example: String) {
        quizNum.text = "문제 \(num)"
        quizContent.text = content
        quizDetail.text = detail
        quizDetailExample.text = example
    }
}

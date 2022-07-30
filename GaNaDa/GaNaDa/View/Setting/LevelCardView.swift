//
//  LevelCardView.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/30.
//

import UIKit

final class LevelCardView: UIView {
    // MARK: - Properties
//    var levelCase: LevelCase!
//    var index: Int!
    
    // MARK: - Methods
    private func viewInit() {
        Bundle.main.loadNibNamed("LevelCardView", owner: self, options: .none)
        addSubview(view)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        levelLabel.minimumScaleFactor = 0.5
        descriptionLabel.minimumScaleFactor = 0.5
    }
    
    func prepareData(levelCase: LevelCase, index: Int) {
        levelImageView.image = levelCase.levelImage
        levelLabel.text = levelCase.rawValue
        let exp = index * 100
        descriptionLabel.text = "누적 경험치 \(exp) ~ \(exp+99)점"
    }
    
    // MARK: - IBOutlets
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - IBActions
    
    // MARK: - Delegates And DataSources
    
    // MARK: - Life Cycles
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
}

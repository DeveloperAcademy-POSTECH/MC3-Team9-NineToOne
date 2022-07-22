//
//  CardCollectionViewCell.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addShadow()
    }
    
    func addShadow() {
        self.clipsToBounds = false
        
        self.contentView.layer.cornerRadius = 16.0
        self.contentView.layer.masksToBounds = false

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.cornerRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
}

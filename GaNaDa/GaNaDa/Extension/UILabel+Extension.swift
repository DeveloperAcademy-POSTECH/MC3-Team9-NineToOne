//
//  UILabel+Extension.swift
//  GaNaDa
//
//  Created by Somin Park on 2022/07/27.
//

import UIKit

extension UILabel {
    func setTargetStringFont(targetString: String, font: UIFont) {
        guard let fullText = text else { return }
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedText = attributedString
    }
    
    func setTargetStringColor(targetString: String, color: UIColor) {
        guard let fullText = text else { return }
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    func setTargetStringStrikeThrough(targetString: String, color: UIColor) {
        guard let fullText = text else { return }
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.strikethroughColor, value: color, range: range)
        attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedText = attributedString
    }
}

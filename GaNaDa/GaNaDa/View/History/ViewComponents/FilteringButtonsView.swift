//
//  FilterButtonsView.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/27.
//

import UIKit

class FilteringButtonsView: UIView {
    lazy private var correctFilteringButton = UIButton()
    lazy private var wrongFilteringButton = UIButton()
    lazy private var incompleteFilteringButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonslayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Buttons AutoLayout
private extension FilteringButtonsView {
    func setButtonslayout() {
        self.addSubview(correctFilteringButton)
        correctFilteringButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            correctFilteringButton.widthAnchor.constraint(equalToConstant: 77),
            correctFilteringButton.heightAnchor.constraint(equalToConstant: 30),
            correctFilteringButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            correctFilteringButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18)
        ])
        correctFilteringButton.setTitle("정답", for: .normal)
        correctFilteringButton.setTitleColor(.black, for: .normal)
        
        
        
        self.addSubview(wrongFilteringButton)
        wrongFilteringButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrongFilteringButton.widthAnchor.constraint(equalToConstant: 77),
            wrongFilteringButton.heightAnchor.constraint(equalToConstant: 30),
            wrongFilteringButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            wrongFilteringButton.leadingAnchor.constraint(equalTo: correctFilteringButton.trailingAnchor, constant: 8)
        ])
        wrongFilteringButton.setTitle("오답", for: .normal)
        wrongFilteringButton.setTitleColor(.black, for: .normal)
        
        
        self.addSubview(incompleteFilteringButton)
        incompleteFilteringButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            incompleteFilteringButton.widthAnchor.constraint(equalToConstant: 77),
            incompleteFilteringButton.heightAnchor.constraint(equalToConstant: 30),
            incompleteFilteringButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            incompleteFilteringButton.leadingAnchor.constraint(equalTo: wrongFilteringButton.trailingAnchor, constant: 8)
        ])
        incompleteFilteringButton.setTitle("미완", for: .normal)
        incompleteFilteringButton.setTitleColor(.black, for: .normal)
    }
}

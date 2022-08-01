//
//  FilterButtonsView.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/27.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(backgroundImage, for: state)
    }
}

enum FilteringButtonType: Int {
    case incomplete = 0
    case correct = 1
    case wrong = 2
}

protocol FilteringButtonsDelegate: AnyObject {
    func filteringButtonPressed(type: FilteringButtonType, isActive: Bool)
}

class FilteringButtonsView: UIView {
    lazy private var correctFilteringButton = UIButton()
    lazy private var wrongFilteringButton = UIButton()
    lazy private var incompleteFilteringButton = UIButton()
    lazy private var isButtonPressed: [Bool] = Array.init(repeating: false, count: 3) {
        didSet {
            correctFilteringButton.layer.backgroundColor = UIColor.customIvory.cgColor
            wrongFilteringButton.layer.backgroundColor = UIColor.customIvory.cgColor
            incompleteFilteringButton.layer.backgroundColor = UIColor.customIvory.cgColor
            if isButtonPressed[1] == true {
                wrongFilteringButton.layer.backgroundColor = UIColor.customOrange.cgColor
            } else if isButtonPressed[0] == true {
                correctFilteringButton.layer.backgroundColor = UIColor.customOrange.cgColor
            } else if  isButtonPressed[2] == true {
                incompleteFilteringButton.layer.backgroundColor = UIColor.customOrange.cgColor
            }
        }
    }
    
    weak var delegate: FilteringButtonsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonslayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonsAction(_ sender: UIButton) {
        if let delegate = delegate {
            switch sender.tag {
            case FilteringButtonType.correct.rawValue:
                isButtonPressed[0].toggle()
                isButtonPressed[1] = false
                isButtonPressed[2] = false
                delegate.filteringButtonPressed(type: .correct, isActive: isButtonPressed[0])
            case FilteringButtonType.wrong.rawValue:
                isButtonPressed[1].toggle()
                isButtonPressed[0] = false
                isButtonPressed[2] = false
                delegate.filteringButtonPressed(type: .wrong, isActive: isButtonPressed[1])
            case FilteringButtonType.incomplete.rawValue:
                isButtonPressed[2].toggle()
                isButtonPressed[0] = false
                isButtonPressed[1] = false
                delegate.filteringButtonPressed(type: .incomplete, isActive: isButtonPressed[2])
            default:
                isButtonPressed[0].toggle()
                isButtonPressed[1] = false
                isButtonPressed[2] = false
                delegate.filteringButtonPressed(type: .correct, isActive: isButtonPressed[0])
            }
        }
    }
}

//MARK: - Buttons AutoLayout
private extension FilteringButtonsView {
    func setButtonslayout() {
        configureCorrectButton()
        configureWrongButton()
        configureIncompleteButton()
    }
    
    func configureCorrectButton() {
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
        correctFilteringButton.layer.cornerRadius = 16
        correctFilteringButton.layer.backgroundColor = UIColor.customIvory.cgColor
        correctFilteringButton.tag = FilteringButtonType.correct.rawValue
        correctFilteringButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
    }
    
    func configureWrongButton() {
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
        wrongFilteringButton.layer.cornerRadius = 16
        wrongFilteringButton.layer.backgroundColor = UIColor.customIvory.cgColor
        wrongFilteringButton.tag = FilteringButtonType.wrong.rawValue
        wrongFilteringButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
    }
    
    func configureIncompleteButton() {
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
        incompleteFilteringButton.layer.cornerRadius = 16
        incompleteFilteringButton.layer.backgroundColor = UIColor.customIvory.cgColor
        incompleteFilteringButton.tag = FilteringButtonType.incomplete.rawValue
        incompleteFilteringButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
    }
}

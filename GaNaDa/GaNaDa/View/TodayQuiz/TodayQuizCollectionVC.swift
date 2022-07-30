//
//  TodayQuizCollectionVC.swift
//  GaNaDa
//
//  Created by hyo on 2022/07/24.
//

import UIKit


final class TodayQuizViewController: UIViewController {

    @IBOutlet weak var todayQuizCollectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userExp: UIProgressView!
    
    var todayQuizs: [Quiz] = [Quiz(question: "나는 ios 개발자가 * 싶다.", typeRawValue: QuizType.blank.rawValue, rightAnswer: "되고", wrongAnswer: "돼고"),
                              Quiz(question: "정말 너를 * 좋니.", typeRawValue: QuizType.blank.rawValue, rightAnswer: "어떡하면", wrongAnswer: "어떻하면"),
                              Quiz(question: "오늘도 안 오면 *.", typeRawValue: QuizType.blank.rawValue, rightAnswer: "어떡해", wrongAnswer: "어떻게")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProgressBar()
        saveUserData(userName: "박가네감자탕둘째며느리의셋째아들")
        requestUserData()
        
        let todayQuizBlankCellNib = UINib(nibName: "QuizTypeBlank", bundle: nil)
        
        todayQuizCollectionView.register(todayQuizBlankCellNib, forCellWithReuseIdentifier: "todayQuizBlankCell")
        
        
        todayQuizCollectionView.dataSource = self
        
        todayQuizCollectionView.collectionViewLayout = creatCompositionalLayout()
    }
    
    func saveUserData(userName: String) {
        if UserDefaults.standard.object(forKey: "userName") == nil {
            UserDefaults.standard.setValue(userName, forKey: "userName")
            UserDefaults.standard.setValue(280, forKey: "userExp")
        }
    }
    
    func requestUserData() {
        userLevel.text = level(rawValue: UserDefaults.standard.integer(forKey: "userExp") / 100)?.name
        userName.text = UserDefaults.standard.string(forKey: "userName")
        userExp.progress = Float(UserDefaults.standard.integer(forKey: "userExp") % 100) / 100.0
    }
    
    func configureProgressBar() {
        userExp.layer.sublayers![1].cornerRadius = 6
        userExp.subviews[1].clipsToBounds = true
        userExp.progressTintColor = .point
        userExp.trackTintColor = .customIvory
    }
}

private extension TodayQuizViewController {
    func creatCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(171))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 11, trailing: 0)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)

            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        return layout
    }
    
}


extension TodayQuizViewController: UICollectionViewDelegate {
    
}

extension TodayQuizViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayQuizs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = todayQuizCollectionView.dequeueReusableCell(withReuseIdentifier: "todayQuizBlankCell", for: indexPath) as! QuizTypeBlank
        
        cell.data = self.todayQuizs[indexPath.item]
        cell.quizIndex.text = "문제 \(indexPath.item + 1)"
        return cell
    }
}

enum level: Int {
    case lowNine = 0
    case highNine
    case lowEight
    case highEight
    case lowSeven
    case highSeven
    case lowSix
    case highSix
    case lowFive
    case highFive
    case lowFour
    case highFour
    case lowThree
    case highThree
    case lowTwo
    case highTwo
    case lowOne
    case highOne
    
    var name: String {
        switch self {
        case .lowNine:
            return "종 9품"
        case .highNine:
            return "정 9품"
        case .lowEight:
            return "종 8품"
        case .highEight:
            return "정 8품"
        case .lowSeven:
            return "종 7품"
        case .highSeven:
            return "정 7품"
        case .lowSix:
            return "종 6품"
        case .highSix:
            return "정 6품"
        case .lowFive:
            return "종 5품"
        case .highFive:
            return "정 5품"
        case .lowFour:
            return "종 4품"
        case .highFour:
            return "정 4품"
        case .lowThree:
            return "종 3품"
        case .highThree:
            return "정 3품"
        case .lowTwo:
            return "종 2품"
        case .highTwo:
            return "정 2품"
        case .lowOne:
            return "종 1품"
        case .highOne:
            return "정 1품"
        }
    }
}

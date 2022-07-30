//
//  TodayQuizCollectionVC.swift
//  GaNaDa
//
//  Created by hyo on 2022/07/24.
//

import UIKit

struct TodayQuizLayoutValue {
    enum CornerRadius {
        static let cell = 16.0
    }
}

final class TodayQuizViewController: UIViewController {

    @IBOutlet weak var todayQuizCollectionView: UICollectionView!
    
    let secretView = UIView()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    let textLabel = UILabel()
//    
//    secretView.addSubview(visualEffectView)
//    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        visualEffectView.topAnchor.constraint(equalTo: cell.topAnchor),
//        visualEffectView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
//        visualEffectView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
//        visualEffectView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
//    ])
//    secretView.addSubview(textLabel)
//    
    
    var currentHour: Int = 12
    var flag = true
    var openTimes = [9,11,18]
    
    var todayQuizs: [Quiz] = [Quiz(question: "나는 ios 개발자가 * 싶다.", type: QuizType.blank, rightAnswer: "되고", wrongAnswer: "돼고"),
                              Quiz(question: "정말 너를 * 좋니.", type: QuizType.blank, rightAnswer: "어떡하면", wrongAnswer: "어떻하면"),
                              Quiz(question: "오늘도 안 오면 *.", type: QuizType.blank, rightAnswer: "어떡해", wrongAnswer: "어떻게")]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        currentHour = Int(formatter.string(from: Date())) ?? 0
        print("\(currentHour)")
        todayQuizCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let todayQuizBlankCellNib = UINib(nibName: "QuizTypeBlank", bundle: nil)
        
        todayQuizCollectionView.register(todayQuizBlankCellNib, forCellWithReuseIdentifier: "todayQuizBlankCell")

        todayQuizCollectionView.dataSource = self
        
        todayQuizCollectionView.collectionViewLayout = creatCompositionalLayout()
    }
}

private extension TodayQuizViewController {
    func creatCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(125))
            
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
        
        if let visualEffectView = cell.subviews.last as? UIVisualEffectView {
            // 시간 조건에 따라
            visualEffectView.removeFromSuperview()
        } else {
            
        }
        
        if currentHour < openTimes[indexPath.item] {
            print("blur \(currentHour) \(openTimes[indexPath.item])")
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
            cell.addSubview(visualEffectView)
            visualEffectView.translatesAutoresizingMaskIntoConstraints = false
            visualEffectView.layer.cornerRadius = TodayQuizLayoutValue.CornerRadius.cell
            visualEffectView.clipsToBounds = true
            visualEffectView.layer.opacity = 0.9
            NSLayoutConstraint.activate([
                visualEffectView.topAnchor.constraint(equalTo: cell.topAnchor),
                visualEffectView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                visualEffectView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                visualEffectView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
            ])
        }
//        cell.flag = currentHour < openTimes[indexPath.item]
//        cell.applyBlur()
        return cell
    }
}

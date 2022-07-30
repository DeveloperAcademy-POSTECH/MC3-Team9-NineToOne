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
    
//    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    var currentHour: Int = 0
    var openTimes = [9,12,18]
    
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
        
        
        if let openTimeLabel = cell.subviews.last as? UILabel {
            openTimeLabel.removeFromSuperview()
            if let visualEffectView = cell.subviews.last as? UIVisualEffectView {
                visualEffectView.removeFromSuperview()
            }
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
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "lock.fill")
            let fullString = NSMutableAttributedString(string: "")
            fullString.append(NSAttributedString(attachment: imageAttachment))
            
            let openHour = String(format: "%02d:00", openTimes[indexPath.item])

            
            fullString.append(NSAttributedString(string: " \(openHour) 공개 예정"))
//            label.attributedText = fullString
            
            let openTimeLabel = UILabel()
            openTimeLabel.attributedText = fullString
            cell.addSubview(openTimeLabel)
            openTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                openTimeLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                openTimeLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            ])
            
        }

        return cell
    }
}

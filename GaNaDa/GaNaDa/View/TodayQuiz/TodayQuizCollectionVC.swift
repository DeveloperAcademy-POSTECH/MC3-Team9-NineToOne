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
    
    enum Size {
        static let cellBorderWidth = 1.0
    }
}

final class TodayQuizViewController: UIViewController {

    @IBOutlet weak var todayQuizCollectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userExp: UIProgressView!
        
    var currentHour: Int = 0
    var openTimes = [9, 12, 18]

    var todayQuizs: [Quiz] = []

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        currentHour = Int(formatter.string(from: Date())) ?? 0
        print("\(currentHour)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicatingActivity()
        NetworkService.requestTodayQuiz { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let todayQuizs):
                    self?.todayQuizs = todayQuizs
                case .failure(let error):
                    self?.showAlertController(title: "네트워크 에러", message: "Error: \(error)")
                }
                self?.todayQuizCollectionView.reloadData()
                self?.stopIndicatingActivity()
            }
        }
        configureProgressBar()
        saveUserData(userName: "박가네감자탕둘째며느리의셋째아들")
        requestUserData()
        
        let todayQuizBlankCellNib = UINib(nibName: "QuizTypeBlank", bundle: nil)
        
        todayQuizCollectionView.register(QuizType2CollectionViewCell.self, forCellWithReuseIdentifier: QuizType2CollectionViewCell.id)
        
        todayQuizCollectionView.register(todayQuizBlankCellNib, forCellWithReuseIdentifier: "todayQuizBlankCell")

        todayQuizCollectionView.dataSource = self
        todayQuizCollectionView.delegate = self
        
        todayQuizCollectionView.collectionViewLayout = creatCompositionalLayout()
    }
    
    func saveUserData(userName: String) {
        if UserDefaults.standard.object(forKey: "userName") == nil {
            UserDefaults.standard.setValue(userName, forKey: "userName")
            UserDefaults.standard.setValue(0, forKey: "userExp")
        }
    }
    
    func requestUserData() {
        userImage.image = LevelCase.level(exp: UserDefaults.standard.integer(forKey: "userExp")).levelImage
        userLevel.text = LevelCase.level(exp: UserDefaults.standard.integer(forKey: "userExp")).rawValue
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentHour < openTimes[indexPath.item] {
            let openHour = String(format: "%02d:00", openTimes[indexPath.item])
            showAlertController(title: "미공개 문제", message: "\(openHour)에 공개됩니다.")
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let quizViewController = storyboard.instantiateViewController(withIdentifier: "QuizView") as? QuizViewController {
                quizViewController.prepareData(quiz: todayQuizs[indexPath.row])
                navigationController?.pushViewController(quizViewController, animated: true)
            }
        }
        
        
    }
}

extension TodayQuizViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayQuizs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if todayQuizs[indexPath.item].quizType == QuizType.blank {
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
                applySecretEffect(cell: cell, hour: openTimes[indexPath.item])
            } else {
                cell.layer.applyShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 20, spread: 0)
            }
            return cell
        } else {
            guard let cell = todayQuizCollectionView.dequeueReusableCell(withReuseIdentifier: QuizType2CollectionViewCell.id, for: indexPath) as? QuizType2CollectionViewCell
            else { return UICollectionViewCell() }
            cell.setQuiz(quizNum: (indexPath.row) + 1, quiz: todayQuizs[indexPath.row])
            if let openTimeLabel = cell.subviews.last as? UILabel {
                openTimeLabel.removeFromSuperview()
                if let visualEffectView = cell.subviews.last as? UIVisualEffectView {
                    visualEffectView.removeFromSuperview()
                }
            }

            if currentHour < openTimes[indexPath.item] {
                applySecretEffect(cell: cell, hour: openTimes[indexPath.item])
            } else {
                cell.layer.applyShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 20, spread: 0)
            }
            return cell
        }
    }
}

private extension TodayQuizViewController {
    func getOpenTimeLabel(openHour : Int) -> UILabel {
        let openTimeLabel = UILabel()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "lock.fill")
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        let openHour = String(format: "%02d:00", openHour)
        fullString.append(NSAttributedString(string: " \(openHour) 공개 예정"))
        openTimeLabel.attributedText = fullString
        return openTimeLabel
    }

    func applySecretEffect(cell: UICollectionViewCell, hour: Int) {
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
        
        let openTimeLabel = getOpenTimeLabel(openHour: hour)
        cell.addSubview(openTimeLabel)
        openTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openTimeLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            openTimeLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
        ])
    }
}

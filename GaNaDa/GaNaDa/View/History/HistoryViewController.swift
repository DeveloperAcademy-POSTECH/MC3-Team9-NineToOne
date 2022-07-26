//
//  HistoryViewController.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/22.
//

import UIKit

struct HistoryLayoutValue {
    enum CornerLadius {
        static let cell = 16.0
    }
    
    enum Padding {
        static let collectionViewFromTop: CGFloat = 140
    }
}

final class HistoryViewController: UIViewController {
    
//    private lazy var historyCollectionView = HistoryCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureCollectionView()
    }
    
}

//// MARK: - Configure CollectionView
//private extension HistoryViewController {
//    func configureCollectionView() {
//        self.view.addSubview(historyCollectionView)
//        historyCollectionView.collectionView.dataSource = self
//        historyCollectionView.collectionView.delegate = self
//    }
//}
//
//// MARK: - Controller Layout
//private extension HistoryViewController {
//    func setCollectionViewLayout() {
//        historyCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            historyCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: HistoryLayoutValue.Padding.collectionViewFromTop),
//            historyCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            historyCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * (tabBarController?.tabBar.frame.height ?? .zero))
//        ])
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//extension HistoryViewController: UICollectionViewDelegate {
//
//}
//
//// MARK: - UICollectionViewDataSource
//extension HistoryViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = historyCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: QuizType2CollectionViewCell.id, for: indexPath) as? QuizType2CollectionViewCell
//        else { return UICollectionViewCell() }
//        cell.layer.cornerRadius = HistoryLayoutValue.CornerLadius.cell
//        return cell
//    }
//}

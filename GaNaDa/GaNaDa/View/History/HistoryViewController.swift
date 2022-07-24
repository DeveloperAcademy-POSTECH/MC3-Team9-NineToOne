//
//  HistoryViewController.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/22.
//

import UIKit


final class HistoryViewController: UIViewController {
    
    @IBOutlet weak private var historyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = historyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        configureCollectionView()
    }
    
}

private extension HistoryViewController {
    func configureCollectionView() {
        historyCollectionView.dataSource = self
        historyCollectionView.delegate = self
        historyCollectionView.register(QuizType2CollectionViewCell.self, forCellWithReuseIdentifier: QuizType2CollectionViewCell.id)
        setCollectionViewLayout()
        historyCollectionView.backgroundColor = .secondarySystemBackground
    }
    
    func setCollectionViewLayout() {
        historyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        historyCollectionView.topAnchor.constraint(equalTo: view.topAnchor,
                                                   constant: 140).isActive = true
        historyCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        historyCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * (tabBarController?.tabBar.frame.height ?? .zero)).isActive = true
    }
}

extension HistoryViewController: UICollectionViewDelegate {
    
}

extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = historyCollectionView.dequeueReusableCell(withReuseIdentifier: QuizType2CollectionViewCell.id, for: indexPath) as? QuizType2CollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .lightGray
        return cell
    }
}

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
        NSLayoutConstraint.activate([
            historyCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            historyCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            historyCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * (tabBarController?.tabBar.frame.height ?? .zero))
        ])
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
        else { return UICollectionViewCell() }
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 16.0
        return cell
    }
}

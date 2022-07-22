//
//  HistoryViewController.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/22.
//

import UIKit

final class HistoryViewController: UIViewController {

    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

    }

}

private extension HistoryViewController {
    func configureCollectionView() {
        historyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        historyCollectionView.topAnchor.constraint(equalTo: view.topAnchor,
                                                   constant: 140).isActive = true
        historyCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        historyCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * (tabBarController?.tabBar.frame.height ?? .zero)).isActive = true
        historyCollectionView.backgroundColor = .secondarySystemBackground
    }
}

extension HistoryViewController: UICollectionViewDelegate {
    
}

extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = QuizType2CollectionViewCell()
        cell.backgroundColor = .cyan
        
        return cell
    }
    
    
}

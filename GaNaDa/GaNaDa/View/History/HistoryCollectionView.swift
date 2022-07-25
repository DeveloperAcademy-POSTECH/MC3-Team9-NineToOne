//
//  HistoryCollectionView.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/25.
//

import UIKit

class HistoryCollectionView: UIView {
    
    lazy var collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0 )))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
}


private extension HistoryCollectionView {
    func configureCollectionView() {
        self.addSubview(self.collectionView)
        collectionView.register(QuizType2CollectionViewCell.self, forCellWithReuseIdentifier: QuizType2CollectionViewCell.id)
        collectionView.backgroundColor = .secondarySystemBackground
    }
    
    func setCollectionViewLayout() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
}

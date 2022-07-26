//
//  HistoryCollectionView.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/25.
//

import UIKit

class HistoryCollectionView: UIView {
    
    lazy var collectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout {
            var newlayout = UICollectionViewFlowLayout()
            newlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            return newlayout
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        setCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
}

private extension HistoryCollectionView {
    func configureCollectionView() {
        self.addSubview(self.collectionView)
    }
    
    func setCollectionViewLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

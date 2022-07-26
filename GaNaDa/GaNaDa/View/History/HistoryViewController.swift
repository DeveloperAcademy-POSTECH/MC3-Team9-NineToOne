//
//  HistoryViewController.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/22.
//

import UIKit

struct HistoryLayoutValue {
    enum Padding {
        static let collectionViewFromTop: CGFloat = 140
    }
}

final class HistoryViewController: UIViewController {
    
    private lazy var historyFilteringButtonsView = FilteringButtonsView()
    private lazy var historyCollectionView = HistoryCollectionView()
    private var quizs = [Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview, Quiz.preview]
    
    override func loadView() {
        super.loadView()
        configureFilteringButtons()
        configureCollectionView()
        setCollectionViewLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Configure Filtering Buttons
private extension HistoryViewController {
    func configureFilteringButtons() {
        self.view.addSubview(historyFilteringButtonsView)
        historyFilteringButtonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyFilteringButtonsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            historyFilteringButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyFilteringButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyFilteringButtonsView.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
}

// MARK: - Configure CollectionView
private extension HistoryViewController {
    func configureCollectionView() {
        self.view.addSubview(historyCollectionView)
        historyCollectionView.collectionView.dataSource = self
        historyCollectionView.collectionView.delegate = self
        historyCollectionView.collectionView.register(QuizType2CollectionViewCell.self, forCellWithReuseIdentifier: QuizType2CollectionViewCell.id)
    }
}

// MARK: - Controller Layout
private extension HistoryViewController {
    func setCollectionViewLayout() {
        historyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: HistoryLayoutValue.Padding.collectionViewFromTop),
            historyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * (tabBarController?.tabBar.frame.height ?? .zero))
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension HistoryViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource
extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = historyCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: QuizType2CollectionViewCell.id, for: indexPath) as? QuizType2CollectionViewCell
        else { return UICollectionViewCell() }
        cell.setQuiz(quizNum: (indexPath.row) + 1, quiz: quizs[indexPath.row])
        return cell
    }
}

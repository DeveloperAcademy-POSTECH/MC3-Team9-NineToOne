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
    
    enum Size {
        static let filteringButtonsHeight: CGFloat = 30
    }
}

final class HistoryViewController: UIViewController {
    
    private lazy var historyFilteringButtonsView = FilteringButtonsView()
    private lazy var historyCollectionView = HistoryCollectionView()
    private var quizs: [Quiz] = []
    
    override func loadView() {
        super.loadView()
        configureFilteringButtons()
        setFilteringButtons()
        configureCollectionView()
        setCollectionViewLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHistoryCollectionView()
    }
    
}

// MARK: - Configure Filtering Buttons
extension HistoryViewController: FilteringButtonsDelegate {
    func filteringButtonPressed(type: FilteringButtonType) {
        print(type)
        // TODO: - HISTORY database 만든 이후 구현 필요
    }
    
    private func configureFilteringButtons() {
        historyFilteringButtonsView.delegate = self
    }
    
    private func setFilteringButtons() {
        self.view.addSubview(historyFilteringButtonsView)
        historyFilteringButtonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyFilteringButtonsView.topAnchor.constraint(equalTo: view.topAnchor, constant: HistoryLayoutValue.Padding.collectionViewFromTop / 2),
            historyFilteringButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyFilteringButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyFilteringButtonsView.heightAnchor.constraint(equalToConstant: HistoryLayoutValue.Size.filteringButtonsHeight)
            
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
    
    func loadHistoryCollectionView() {
        ICloudService.requestAllHistoryQuizs() { quizs in
            self.quizs = quizs
            DispatchQueue.main.async {
                self.historyCollectionView.collectionView.reloadData()
            }
        }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let quizViewController = storyboard.instantiateViewController(withIdentifier: "QuizView") as? QuizViewController {
            quizViewController.prepareData(quiz: quizs[indexPath.row])
            navigationController?.pushViewController(quizViewController, animated: true)
        }
    }
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

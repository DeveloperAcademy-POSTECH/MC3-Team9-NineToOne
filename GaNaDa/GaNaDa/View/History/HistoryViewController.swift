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
    private var rawQuizsByDate: [Dictionary<Date, [Quiz]>.Element] = []
    private var quizsByDate: [Dictionary<Date, [Quiz]>.Element] = []
    
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
    func filteringButtonPressed(type: FilteringButtonType, isActive: Bool) {
        if isActive {
            quizsByDate = rawQuizsByDate.filter({
                $0.value.filter {
                    $0.stateRawValue == type.rawValue
                }.count > 0
            })
            for idx in quizsByDate.indices {
                let new = quizsByDate[idx].value.filter({
                    $0.stateRawValue == type.rawValue
                })
                quizsByDate[idx].value = new
            }
            DispatchQueue.main.async {
                self.historyCollectionView.collectionView.reloadData()
            }
        } else {
            quizsByDate = rawQuizsByDate
            DispatchQueue.main.async {
                self.historyCollectionView.collectionView.reloadData()
            }
        }
        // TODO: - HISTORY database 만든 이후 구현 필요
    }
    
    private func configureFilteringButtons() {
        historyFilteringButtonsView.delegate = self
    }
    
    private func setFilteringButtons() {
        self.view.addSubview(historyFilteringButtonsView)
        historyFilteringButtonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyFilteringButtonsView.topAnchor.constraint(equalTo: view.topAnchor, constant: HistoryLayoutValue.Padding.collectionViewFromTop * 0.7),
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
        let todayQuizBlankCellNib = UINib(nibName: "QuizTypeBlank", bundle: nil)
        let solvedQuizBlankCellNib = UINib(nibName: "SolvedQuizType1CollectionViewCell", bundle: nil)
        let solvedQuizChoiceCellNib = UINib(nibName: "SolvedQuizType2CollectionViewCell", bundle: nil)
        historyCollectionView.collectionView.register(todayQuizBlankCellNib, forCellWithReuseIdentifier: "todayQuizBlankCell")
        historyCollectionView.collectionView.register(QuizType2CollectionViewCell.self, forCellWithReuseIdentifier: QuizType2CollectionViewCell.id)
        historyCollectionView.collectionView.register(solvedQuizBlankCellNib.self, forCellWithReuseIdentifier: SolvedQuizType1CollectionViewCell.identifier)
        historyCollectionView.collectionView.register(solvedQuizChoiceCellNib.self, forCellWithReuseIdentifier: SolvedQuizType2CollectionViewCell.identifier)
        historyCollectionView.collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    func loadHistoryCollectionView() {
        ICloudService.requestAllHistoryQuizs() { quizs in
            self.quizs = quizs
            self.rawQuizsByDate = quizs.sliced(by: [.year, .month, .day], for: \.publishedDate).sorted {  $0.key > $1.key }
            self.quizsByDate = self.rawQuizsByDate
            DispatchQueue.main.async {
                self.historyCollectionView.collectionView.reloadData()
            }
        }
    }
}

extension Array {
    func sliced(by dateComponents: Set<Calendar.Component>, for key: KeyPath<Element, Date?>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur[keyPath: key] ?? Date())
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        return groupedByDateComponents
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.quizsByDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            sectionHeader.label.text = format.string(from: quizsByDate[indexPath.section].key)
            sectionHeader.label.textColor = .customColor(.customGray)
            sectionHeader.label.font = .customFont(.content)
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

// MARK: - UICollectionViewDataSource
extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizsByDate[section].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //랜스 셀 합치기
        if quizsByDate[indexPath.section].value[indexPath.row].stateRawValue == 0, quizsByDate[indexPath.section].value[indexPath.row].typeRawValue == 0  {
            guard let cell = historyCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: "todayQuizBlankCell", for: indexPath) as? QuizType2CollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        } else if quizsByDate[indexPath.section].value[indexPath.row].stateRawValue == 0, quizsByDate[indexPath.section].value[indexPath.row].typeRawValue == 1  {
            guard let cell = historyCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: QuizType2CollectionViewCell.id, for: indexPath) as? QuizType2CollectionViewCell
            else { return UICollectionViewCell() }
            cell.setQuiz(quizNum: (indexPath.row) + 1, quiz: quizsByDate[indexPath.section].value[indexPath.row])
            return cell
            
        } else if quizsByDate[indexPath.section].value[indexPath.row].typeRawValue == 0  {
            guard let cell = historyCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: SolvedQuizType1CollectionViewCell.identifier, for: indexPath) as? SolvedQuizType1CollectionViewCell
            else { return UICollectionViewCell() }
            cell.setBlankQuiz(indexPath: indexPath, quiz: quizsByDate[indexPath.section].value[indexPath.row])
            return cell
            
        } else {
            guard let cell = historyCollectionView.collectionView.dequeueReusableCell(withReuseIdentifier: SolvedQuizType2CollectionViewCell.identifier, for: indexPath) as? SolvedQuizType2CollectionViewCell
            else { return UICollectionViewCell() }
            cell.setChoiceQuiz(indexPath: indexPath, quiz: quizsByDate[indexPath.section].value[indexPath.row])
            return cell
        }
    }
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - QuizType2LayoutValue.Padding.cellHoriz * 2
        return CGSize(width: width, height: 125)
    }
}

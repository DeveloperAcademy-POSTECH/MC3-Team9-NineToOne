//
//  CardViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/22.
//

import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var quizCollectionView: UICollectionView!
    
    let transitionManger = CardTransitionManager()
    
//    var appStoreTransition = AppContentTransitionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QuizCardView")
        quizCollectionView.delegate = self
        quizCollectionView.dataSource = self
        quizCollectionView.reloadData()
    }
    
}

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCardView", for: indexPath) as! CardCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: .infinity, height: self.view.frame.height / 4) //* ( 171 / 844 ))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let appContentVC = AppContentViewController()
//        appStoreTransition.indexPath = indexPath
//        appStoreTransition.superViewcontroller = appContentVC
        
        let quizDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizDetailView")
        //        quizDetailView.prepareViewModel(viewModel: )
        quizDetailViewController.modalPresentationStyle = .custom
//        quizDetailViewController.transitioningDelegate = appStoreTransition
//        quizDetailViewController.transitioningDelegate = transitionManger
//        quizDetailViewController.modalPresentationCapturesStatusBarAppearance = true
        present(quizDetailViewController, animated: true, completion: nil)
        
        // To wake up the UI, Apple issue with cells with selectionStyle = .none
        // 해당 코드 의미 조사 필요
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    func selectedCellQuizView() -> UIView? {
        
        guard let indexPath = quizCollectionView.indexPathsForSelectedItems?.first else {
            return nil
        }
        
        let item = quizCollectionView.cellForItem(at: indexPath)
        guard let cardView = item?.contentView else { return nil }
        
        return cardView
    }
}

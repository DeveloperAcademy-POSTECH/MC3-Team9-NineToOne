//
//  QuizDetailViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/22.
//

import UIKit

class QuizDetailViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var snapshotView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 10.0
        imageView.layer.shadowOffset = CGSize(width: -1, height: 2)
        imageView.isHidden = true
        return imageView
    }()
    
    func createSnapshotOfView() {
        let snapshotImage = view.createSnapshot()
        snapshotView.image = snapshotImage
        scrollView.addSubview(snapshotView)
        
        let topPadding = UIWindow.topPadding
        snapshotView.frame = CGRect(x: 0, y: -topPadding, width: view.frame.size.width, height: view.frame.size.height)
        
        scrollView.delegate = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

}

extension QuizDetailViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPositionForDismissal: CGFloat = 20.0
        var yContentOffset = scrollView.contentOffset.y
        let topPadding = UIWindow.topPadding
        
        yContentOffset += topPadding
        
//        updateCloseButton(yContentOffset: yContentOffset)
        
        if scrollView.isTracking {
            scrollView.bounces = true
        } else {
            scrollView.bounces = yContentOffset > 500
        }
        
        if yContentOffset < 0 && scrollView.isTracking {
//            viewsAreHidden = true
            snapshotView.isHidden = false
            
            let scale = (100 + yContentOffset) / 100
            snapshotView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            snapshotView.layer.cornerRadius = -yContentOffset > yPositionForDismissal ? yPositionForDismissal : -yContentOffset
            
            if yPositionForDismissal + yContentOffset <= 0 {
                self.close()
            }
            
        } else {
//            viewsAreHidden = false
            
            snapshotView.isHidden = true
        }
        
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.bounces = true
    }
    
//    func updateCloseButton(yContentOffset: CGFloat) {
        
//        let topPadding = UIWindow.topPadding
        
//        if yContentOffset < 450 - topPadding && cardView?.cardModel.backgroundType == .dark {
//            closeButton.setImage(UIImage(named: "lightOnDark"), for: .normal)
//        } else {
//            closeButton.setImage(UIImage(named: "darkOnLight"), for: .normal)
//        }
        
//    }

}

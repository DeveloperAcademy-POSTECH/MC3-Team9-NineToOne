//
//  CardTransitionManager.swift
//  appstoreclone
//
//  Created by Andrei Blaj on 10/13/20.
//

import UIKit
enum CardViewMode {
    case full
    case card
}

//
//  UIWindow+Extension.swift
//  appstoreclone
//
//  Created by Andrei Blaj on 10/6/20.
//

import UIKit

extension UIWindow {
  
    private class var key: UIWindow {
        
        if #available(iOS 13.0, *) {
            guard let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first else {
                fatalError("Fatal Error: now window is set to keyWindow")
            }
            
            return keyWindow
        } else {
            guard let keyWindow = UIApplication.shared.keyWindow else {
                fatalError("Fatal Error: now window is set to keyWindow")
            }
            return keyWindow
        }
        
    }
  
    private class var keySafeAreaInsets: UIEdgeInsets {
        guard #available(iOS 11.0, *) else { return .zero }
        return UIWindow.key.safeAreaInsets
    }
    
    class var topPadding: CGFloat {
        return UIWindow.keySafeAreaInsets.top
    }
    
    class var bottomPadding: CGFloat {
        return UIWindow.keySafeAreaInsets.bottom
    }
    
}



extension UIView {
    
    func createSnapshot() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        drawHierarchy(in: frame, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}

enum CardTransitionType {
    case presentation
    case dismissal
    
    var blurAlpha: CGFloat { return self == .presentation ? 1 : 0 }
    var dimAlpha: CGFloat { return self == .presentation ? 0.5 : 0 }
    var closeAlpha: CGFloat { return self == .presentation ? 1 : 0 }
    var cornerRadius: CGFloat { return self == .presentation ? 20.0 : 0.0 }
    var cardMode: CardViewMode { return self == .presentation ? .card : .full }
    var next: CardTransitionType { return self == .presentation ? .dismissal : .presentation }
}

class CardTransitionManager: NSObject {
    
    let transitionDuration: Double = 0.8
    var transition: CardTransitionType = .presentation
    let shrinkDuration: Double = 0.2
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //    lazy var closeButton: UIButton = {
    //        let button = UIButton(type: UIButton.ButtonType.custom)
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        return button
    //    }()
    
    // MARK: Helper Methods -
    private func addBackgroundViews(to containerView: UIView) {
        blurEffectView.frame = containerView.frame
        blurEffectView.alpha = transition.next.blurAlpha
        containerView.addSubview(blurEffectView)
        
        dimmingView.frame = containerView.frame
        dimmingView.alpha = transition.next.dimAlpha
        containerView.addSubview(dimmingView)
    }
    
    //    private func createCardViewCopy(cardView: CardView) -> CardView {
    //        let cardModel = cardView.cardModel
    //        cardModel.viewMode = transition.cardMode
    //        let appView = AppView(cardView.appView?.viewModel)
    //        let cardViewCopy = CardView(cardModel: cardModel, appView: appView)
    //        return cardViewCopy
    //    }
    
}

extension CardTransitionManager: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        addBackgroundViews(to: containerView)
        
        let fromView = transitionContext.viewController(forKey: .from)
        let toView = transitionContext.viewController(forKey: .to)
        
        guard let cardView = (transition == .presentation)
                ? ((fromView as? UITabBarController)?.selectedViewController as! CardViewController).selectedCellQuizView()
                : ((toView as? UITabBarController)?.selectedViewController as! CardViewController).selectedCellQuizView() else {
            return
        }
        
        let cardViewCopy = cardView //createCardViewCopy(cardView: cardView)
        containerView.addSubview(cardViewCopy)
        cardView.isHidden = true
        
        let absoluteCardViewFrame = cardView.convert(cardView.frame, to: nil)
        cardViewCopy.frame = absoluteCardViewFrame
        cardViewCopy.layoutIfNeeded()
        
        //        whiteView.frame = transition == .presentation ? cardViewCopy.containerView.frame : containerView.frame
        whiteView.frame = transition == .presentation ? cardViewCopy.frame : containerView.frame
        
        whiteView.layer.cornerRadius = transition.cornerRadius
        //        cardViewCopy.insertSubview(whiteView, aboveSubview: cardViewCopy.shadowView)
        
        // MARK: Close Button
        //        if cardView.cardModel.backgroundType == .light {
        //            closeButton.setImage(UIImage(named: "darkOnLight"), for: .normal)
        //        } else {
        //            closeButton.setImage(UIImage(named: "lightOnDark"), for: .normal)
        //        }
        
        //        cardViewCopy.containerView.addSubview(closeButton)
        //        NSLayoutConstraint.activate([
        //            closeButton.topAnchor.constraint(equalTo: cardViewCopy.shadowView.topAnchor, constant: 20.0),
        //            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
        //            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1.0),
        //            closeButton.rightAnchor.constraint(equalTo: cardViewCopy.shadowView.rightAnchor, constant: -20.0)
        //        ])
        
        if transition == .presentation {
            let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizDetailView")//as! DetailView
            containerView.addSubview(detailView.view)
            //            detailView.viewsAreHidden = true
            //            closeButton.alpha = transition.next.closeAlpha
            
            moveAndConvertToCardView(cardView: cardViewCopy, containerView: containerView, yOriginToMoveTo: 0) {
//                detailView.viewsAreHidden = false
                cardViewCopy.removeFromSuperview()
                cardView.isHidden = false
//                detailView.createSnapshotOfView()
                transitionContext.completeTransition(true)
            }
            
        } else {
            // Dismissal
            let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizDetailView") //fromView as! DetailView
            //            detailView.viewsAreHidden = true
            //            closeButton.alpha = transition.next.closeAlpha
            
            //            cardViewCopy.frame = CGRect(x: 0, y: 0,
            //                                        width: (detailView.cardView?.frame.size.width)!,
            //                                        height: 150) // (detailView.cardView?.frame.size.height)!)
            
            moveAndConvertToCardView(cardView: cardViewCopy, containerView: containerView, yOriginToMoveTo: absoluteCardViewFrame.origin.y) {
                cardView.isHidden = false
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
    //    func makeShrinkAnimator(for cardView: CardView) -> UIViewPropertyAnimator {
    func makeShrinkAnimator(for cardView: UIView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: shrinkDuration, curve: .easeOut) {
            cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.dimmingView.alpha = 0.05
        }
    }
    
    //    func makeExpandContractAnimator(for cardView: CardView, in containerView: UIView, yOrigin: CGFloat) -> UIViewPropertyAnimator {
    func makeExpandContractAnimator(for cardView: UIView, in containerView: UIView, yOrigin: CGFloat) -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.75, initialVelocity: CGVector(dx: 0, dy: 4))
        let animator = UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            cardView.transform = .identity
            cardView.layer.cornerRadius = self.transition.next.cornerRadius
            //            cardView.containerView.layer.cornerRadius = self.transition.next.cornerRadius
            cardView.frame.origin.y = yOrigin
            
            self.blurEffectView.alpha = self.transition.blurAlpha
            self.dimmingView.alpha = self.transition.dimAlpha
            //            self.closeButton.alpha = self.transition.closeAlpha
            
            self.whiteView.layer.cornerRadius = self.transition.next.cornerRadius
            
            containerView.layoutIfNeeded()
            
//            self.whiteView.frame = self.transition == .presentation ? containerView.frame : cardView.containerView.frame
            self.whiteView.frame = self.transition == .presentation ? containerView.frame : cardView.frame
        }
        
        return animator
    }
    
//    func moveAndConvertToCardView(cardView: CardView, containerView: UIView, yOriginToMoveTo: CGFloat, completion: @escaping () -> ()) {
    func moveAndConvertToCardView(cardView: UIView, containerView: UIView, yOriginToMoveTo: CGFloat, completion: @escaping () -> ()) {
        
        let shrinkAnimator = makeShrinkAnimator(for: cardView)
        let expandContractAnimator = makeExpandContractAnimator(for: cardView, in: containerView, yOrigin: yOriginToMoveTo)
        
        expandContractAnimator.addCompletion { _ in
            completion()
        }
        
        if transition == .presentation {
            shrinkAnimator.addCompletion { _ in
                cardView.layoutIfNeeded()
//                cardView.updateLayout(for: self.transition.next.cardMode)
                expandContractAnimator.startAnimation()
            }
            
            shrinkAnimator.startAnimation()
        } else {
            cardView.layoutIfNeeded()
//            cardView.updateLayout(for: self.transition.next.cardMode)
            expandContractAnimator.startAnimation()
        }
        
    }
    
}

extension CardTransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .presentation
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .dismissal
        return self
    }
    
}

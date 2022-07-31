//
//  UIWindow+Extension.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/31.
//

import Foundation
import UIKit

extension UIWindow {
    private static let association = ObjectAssociation<UIActivityIndicatorView>()
    
    var activityIndicator: UIActivityIndicatorView {
        set {
            UIWindow.association[self] = newValue
        }
        
        get {
            if let indicator = UIWindow.association[self] {
                return indicator
            } else {
                UIWindow.association[self] = UIActivityIndicatorView.customIndicator(at: self.center)
                
                return UIWindow.association[self]!
            }
        }
    }
    
    // MARK: - Activity Indicator
    public func startIndicatingActivity() {
        DispatchQueue.main.async {
            self.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    public func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
}

public final class ObjectAssociation<T: AnyObject> {
    private let policy: objc_AssociationPolicy
    
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }
    
    public subscript(index: AnyObject) -> T? {
        get {
            return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T?
        }
        
        set {
            objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy)
        }
    }
}


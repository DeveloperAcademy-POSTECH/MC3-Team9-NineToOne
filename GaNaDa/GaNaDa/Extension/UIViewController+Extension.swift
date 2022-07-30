//
//  UIViewController+Extension.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/27.
//

import UIKit

extension UIViewController {
    /// NavigationBar 설정
    func setNavigationBar(navigationTitle: String, popGesture: Bool = false, hidesBackButton: Bool = false) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = popGesture
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = ""
        navigationItem.backBarButtonItem = backBarBtnItem
        navigationItem.setHidesBackButton(hidesBackButton, animated: true)
        
        navigationItem.title = navigationTitle
    }
}

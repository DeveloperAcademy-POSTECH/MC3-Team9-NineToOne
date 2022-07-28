//
//  UIViewController+Extension.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/27.
//

import UIKit

extension UIViewController {
    /// NavigationBar 설정
    func setNavigationBar(navigationTitle: String, showBackButton: Bool = true) {
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationItem.backBarButtonItem = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.setHidesBackButton(showBackButton, animated: true)
        navigationItem.title = navigationTitle
    }
}

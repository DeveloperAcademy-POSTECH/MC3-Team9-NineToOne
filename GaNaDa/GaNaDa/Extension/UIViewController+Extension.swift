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
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = " "
        navigationItem.backBarButtonItem = backBarBtnItem
        navigationItem.setHidesBackButton(hidesBackButton, animated: true)
        
        navigationItem.title = navigationTitle
    }
    
    func showAlertController(title: String, message: String = "", addCancel: Bool = false, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .default) { (alertAction) in
            if let completion = completion {
                completion()
            }
        }
        alertController.addAction(acceptAction)
        
        if addCancel {
            alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func startIndicatingActivity() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.startIndicatingActivity()
    }
    
    func stopIndicatingActivity() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.stopIndicatingActivity()
    }
}

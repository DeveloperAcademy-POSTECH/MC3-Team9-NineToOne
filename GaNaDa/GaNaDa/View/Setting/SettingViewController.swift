//
//  SettingViewController.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/30.
//

import UIKit

final class SettingViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Methods
    private func loadData() {
        let userExp = UserDefaultManager.userExp
        levelImageView.image = LevelCase.level(exp: userExp).levelImage
        levelLabel.text = LevelCase.level(exp: userExp).rawValue
        nameLabel.text = UserDefaultManager.userName
        nameLabel.sizeToFit()
        levelLabel.sizeToFit()
        pushNotificationSwitch.isOn = UserDefaultManager.pushNotification
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapSwitch(_:)))
        pushNotificationSwitch.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var pushNotificationSwitch: UISwitch!
    
    // MARK: - IBActions
    @IBAction func toggleQuizNotification(_ sender: UISwitch) {
        NotificationManager.getAuthorizationStatus { status in
            DispatchQueue.main.async { [weak self] in
                switch status {
                case .authorized:
                    UserDefaultManager.setPushNotification(sender.isOn)
                default:
                    self?.showAlertController(title: "알림 권한 필요", message: "설정페이지에서 알림 설정을 켜주세요.", addCancel: true) {
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Objective-C Runtime Method
    @objc func tapSwitch(_ sender: UITapGestureRecognizer) {
//        NotificationManager.getAuthorizationStatus { status in
//            DispatchQueue.main.async { [weak self] in
//                switch status {
//                case .authorized:
//                    UserDefaultManager.setPushNotification(sender.isOn)
//                default:
//                    self?.showAlertController(title: "알림 권한 필요", message: "설정페이지에서 알림 설정을 켜주세요.", addCancel: true) {
//                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                            return
//                        }
//                        if UIApplication.shared.canOpenURL(settingsUrl) {
//                            UIApplication.shared.open(settingsUrl)
//                        }
//                    }
//                }
//            }
//        }
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(navigationTitle: "설정", popGesture: true)
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationManager.getAuthorizationStatus { status in
//            DispatchQueue.main.async { [weak self] in
//                self?.pushNotificationSwitch.isEnabled = (status == .authorized)
//            }
//        }
    }
}

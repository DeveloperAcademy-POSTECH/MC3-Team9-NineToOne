//
//  NotificationManager.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/08/01.
//

import Foundation
import UserNotifications

enum NotificationManager {
    static func getAuthorizationStatus(_ handler: @escaping (UNAuthorizationStatus) -> ()) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            handler(settings.authorizationStatus)
        }
    }
    
    static func registerNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.badge = 1
                content.title = "로컬 푸시"
                content.subtitle = "서브 타이틀"
                content.body = "바디바디바디받비ㅏ디바딥다비답디ㅏㅂ딥다비다비답다ㅣ"
                content.sound = .default
                content.userInfo = ["name": "tree"]
                
                //5초 후, 반복하지 않음
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: "firstPush", content: content, trigger: trigger)
                
                //발송을 위한 센터에 추가
                UNUserNotificationCenter.current().add(request)
            } else {
                //사용자가 알림을 허용하지 않음
                print("알림 허용 않음")
            }
        }
    }
}

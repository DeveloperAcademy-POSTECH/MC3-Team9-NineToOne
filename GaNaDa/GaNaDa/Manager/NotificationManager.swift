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
                content.title = "문제 도착"
                content.body = "오늘의 첫번째 문제가 도착했습니다!"
                content.sound = .default

                let content2 = UNMutableNotificationContent()
                content2.title = "문제 도착"
                content2.body = "오늘의 두번째 문제가 도착했습니다!"
                content2.sound = .default

                let content3 = UNMutableNotificationContent()
                content3.title = "문제 도착"
                content3.body = "오늘의 세번째 문제가 도착했습니다!"
                content3.sound = .default
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = 9
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: "firstPush", content: content, trigger: trigger)
                
                var dateComponents2 = DateComponents()
                dateComponents2.calendar = Calendar.current
                dateComponents2.hour = 12
                let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents2, repeats: true)
                let request2 =  UNNotificationRequest(identifier: "secondPush", content: content2, trigger: trigger2)
                
                var dateComponents3 = DateComponents()
                dateComponents3.calendar = Calendar.current
                dateComponents3.hour = 18
                let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateComponents3, repeats: true)
                let request3 =  UNNotificationRequest(identifier: "thirdPush", content: content3, trigger: trigger3)
                
                UNUserNotificationCenter.current().add(request)
                UNUserNotificationCenter.current().add(request2)
                UNUserNotificationCenter.current().add(request3)
            } else {
                print("알림 허용 않음")
            }
        }
    }
}

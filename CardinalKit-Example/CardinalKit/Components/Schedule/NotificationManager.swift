//
//  NotificationManager.swift
//  CardinalKit_Example
//
//  Created by Hayden hofmann on 2/16/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UserNotifications
import SwiftUI


class NotificationManager {
    
    static let share = NotificationManager()
    
    
    func requestAuthorization(_ completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
            completion(success, error)
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "EMA SURVEY AVAILABLE"
        content.subtitle = "please take your survey"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        dateComponents.hour = 13
        dateComponents.minute = 0
        let trigger1 = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        
        let request1  = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger1)
        UNUserNotificationCenter.current().add(request1)
        
        dateComponents.hour = 19
        dateComponents.minute = 0
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        
        let request2 = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger2)
        UNUserNotificationCenter.current().add(request2)
        
        
        
        
        
    }
    
}

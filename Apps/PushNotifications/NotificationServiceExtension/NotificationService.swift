//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Carlson Yuan on 2024/2/28.
//  Copyright © 2024 Carlson. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    let defaults = UserDefaults(suiteName: "group.com.carlson.demo")
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        var count: Int = defaults?.value(forKey: "count") as! Int
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "\(bestAttemptContent.title) "
            bestAttemptContent.body = "\(bestAttemptContent.body) "
            bestAttemptContent.badge = count as NSNumber
            count = count + 1
            defaults?.set(count, forKey: "count")
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
     
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
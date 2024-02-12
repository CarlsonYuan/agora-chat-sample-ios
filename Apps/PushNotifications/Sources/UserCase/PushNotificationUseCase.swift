//
//  PushNotificationUseCase.swift
//  PushNotifications
//
//  Created by Carlson Yuan on 2023/8/3.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation
import AgoraChat

class PushNotificationUseCase {
    func registerPushToken(deviceToken: Data) {
        AgoraChatClient.shared().registerForRemoteNotifications(withDeviceToken: deviceToken) { error in
            if let error = error {
                print("APNS registration failed. \(error.debugDescription)")
                return
            }
            print("APNS Token is registered.")
        }
    }
}

extension AppDelegate {
    func applicationDidEnterBackground(_ application: UIApplication) {
        AgoraChatClient.shared().applicationDidEnterBackground(application)
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        AgoraChatClient.shared().applicationWillEnterForeground(application)
    }
}

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
    public static let shared = PushNotificationUseCase()
    
    func registerDeviceToken(deviceToken: Data) {
        AgoraChatClient.shared().registerForRemoteNotifications(withDeviceToken: deviceToken) { error in
            if let error = error {
                print("APNS registration failed. \(error.errorDescription ?? "With no error description")")
                return
            }
            print("APNS Token is registered.")
        }
    }
    
    func setPushNotification(enable: Bool) {
            if enable {
                let smOption = AgoraChatSilentModeParam(paramType: .remindType)
                smOption.remindType = .all
                AgoraChatClient.shared().pushManager?.setSilentModeForAll(smOption, completion: { result, error in
                    if let error = error {
                        print("set silent model failed. \(error.errorDescription ?? "With no error description")")
                        return
                    }
                    print("set silent model success.")
                })
            }
            else {
                let smOption = AgoraChatSilentModeParam(paramType: .remindType)
                smOption.remindType = .none
                AgoraChatClient.shared().pushManager?.setSilentModeForAll(smOption, completion: { result, error in
                    if let error = error {
                        print("set silent model failed. \(error.errorDescription ?? "With no error description")")
                        return
                    }
                    print("set silent model success.")
                })
            }
        }
}

extension AppDelegate {
    func applicationDidEnterBackground(_ application: UIApplication) {
        AgoraChatClient.shared().applicationDidEnterBackground(application)
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        AgoraChatClient.shared().applicationWillEnterForeground(application)
        
        UserDefaults(suiteName: "group.com.carlson.demo")?.set(1, forKey: "count")
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

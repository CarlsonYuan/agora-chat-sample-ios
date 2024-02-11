//
//  AppDelegate.swift
//  PushNotifications
//
//  Created by easemob on 2024/1/25.
//  Copyright © 2024 Carlson. All rights reserved.
//

import UIKit
import CommonModule

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        EnvironmentUseCase.initializeAgoraChatSDK(appKey: .sample, apnsCertName: "dev_push_notification_chat")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = createLoginViewController()
        window?.makeKeyAndVisible()
        
        self.registerForPushNotifications()
        
        return true
    }
    
    private func createLoginViewController() -> LoginViewController {
        return LoginViewController(didConnectUser: { [weak self] _ in
            self?.presentMainViewController()
        })
    }
    
    private func presentMainViewController() {
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([
            UINavigationController(rootViewController: GroupListViewController())
        ], animated: false)
        tabBarController.modalPresentationStyle = .fullScreen
        window?.rootViewController?.present(tabBarController, animated: true)
    }
    
    private func registerForPushNotifications() {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            guard granted else { return }
            self?.getNotificationSettings()
        }
    }
    
    private func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
          guard settings.authorizationStatus == .authorized else { return }
          DispatchQueue.main.async {
              // register for Remote Notifications:
            UIApplication.shared.registerForRemoteNotifications()
          }
      }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // register a device token to the Agora Chat server
        PushNotificationUseCase().registerPushToken(deviceToken: deviceToken)
        
        let tokenString = hexadecimalString(fromData: deviceToken)
        print("Device Token: \(tokenString)")
    }
    func hexadecimalString(fromData data: Data) -> String {
        let hexString = data.map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
}

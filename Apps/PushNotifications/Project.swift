import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let name = "PushNotifications"
let project = Project(
    name: name,
    organizationName: "Carlson",
    targets: [
        makeAppTarget(
            name: name,
            platform: .iOS,
            dependencies: [
                .project(target: "CommonModule", path: .relativeToRoot("Modules/CommonModule"))
            ]
        ),
        makeNotificationServiceExtensionTarget(name: "NotificationServiceExtension", platform: .iOS)
    ]
)

private func makeAppTarget(name: String, platform: Platform, dependencies: [TargetDependency]) -> Target {
    let platform: Platform = platform
    let infoPlist: [String: Plist.Value] = [
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "UIMainStoryboardFile": "Main",
        "UILaunchStoryboardName": "LaunchScreen",
    ]
    let mainTarget = Target(
        name: name,
        platform: platform,
        product: .app,
        bundleId: "carlson.agora.chat.\(name)",
        deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
        infoPlist: .extendingDefault(with: infoPlist),
        sources: [.glob(.relativeToManifest("Sources/**"))],
        resources: [.glob(pattern: .relativeToManifest("Resources/**"))],
        entitlements: .file(path: .relativeToManifest("\(name).entitlements")),
        dependencies: dependencies,
        settings: .settings(
            base: SettingsDictionary().automaticCodeSigning(devTeam: "JC854K845H"),
            debug: SettingsDictionary().automaticCodeSigning(devTeam: "JC854K845H"),
            release: SettingsDictionary().automaticCodeSigning(devTeam: "JC854K845H"),
            defaultSettings: .recommended
        )
    )
    return mainTarget
}

private func makeNotificationServiceExtensionTarget(name: String, platform: Platform) -> Target {
    let platform: Platform = platform
    let mainTarget = Target(
        name: name,
        platform: platform,
        product: .appExtension,
        bundleId: "carlson.agora.chat.\(name)",
        deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
        infoPlist: .file(path: .relativeToManifest("\(name)/Info.plist")),
        sources: [.glob(.relativeToManifest("\(name)/**"))],
        entitlements: .file(path: .relativeToManifest("\(name)/\(name).entitlements")),
        settings: .settings(
            base: SettingsDictionary().automaticCodeSigning(devTeam: "JC854K845H"),
            debug: SettingsDictionary().automaticCodeSigning(devTeam: "JC854K845H"),
            release: SettingsDictionary().automaticCodeSigning(devTeam: "JC854K845H"),
            defaultSettings: .recommended
        )
    )
    return mainTarget
}

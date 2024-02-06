import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
    name: "CommonModule",
    organizationName: "Carlson",
    targets: [
        Target(
            name: "CommonModule",
            platform: .iOS,
            product: .framework,
            bundleId: "com.agora.chat.CommonModule",
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "AgoraChat")
            ]
        ),
    ]
)

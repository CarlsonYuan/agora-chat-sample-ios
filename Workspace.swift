//
//  Workspace.swift
//  agora-chat-sample-iosManifests
//
//  Created by Carlson Yuan on 2023/8/29.
//

import ProjectDescription

let workspace = Workspace.create()

extension Workspace {
    
    static func create() -> Workspace {
        Workspace(
            name: "Samples",
            projects: [
                "Apps/**",
                "Modules/**"
            ],
            schemes: [],
            additionalFiles: ["README.md"]
        )
    }
    
}

// MARK: - Scheme

extension Workspace {
    
    static func schemes(appNames: [String]) -> [Scheme] {
        appNames.map {
            appScheme(name: $0)
        }
    }
    
    static func appScheme(name: String) -> Scheme {
        Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(
                targets: [.project(path: "Apps/\(name)", target: name)],
                preActions: []
            ),
            runAction: .runAction(
                executable: .project(path: "Apps/\(name)", target: name)
            )
        )
    }

}

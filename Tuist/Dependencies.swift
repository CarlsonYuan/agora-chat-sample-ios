//
//  Dependencies.swift
//  Config
//
//  Created by Carlson Yuan on 2023/8/30.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/AgoraIO/AgoraChat_iOS", requirement: .upToNextMajor(from: "1.2.0"))
    ],
    platforms: [.iOS]
)

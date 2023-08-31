//
//  Dependencies.swift
//  Config
//
//  Created by Carlson Yuan on 2023/8/30.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/AgoraIO/AgoraChat_iOS", requirement: .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", .upToNextMinor(from: "1.1.1700"))
    ],
    platforms: [.iOS]
)

//
//  Package.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 01/09/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

// swift-tools-version: 5.5
import PackageDescription

let package = Package(
    name: "FoodPin",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .executable(name: "FoodPin", targets: ["FoodPin"])
    ],
    dependencies: [
        .package(url: "https://github.com/kamilkk/ModernDesignSystem", from: "1.0.0"),
        .package(url: "https://github.com/kamilkk/ModernMagazineLayout", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "FoodPin",
            dependencies: [
                "ModernDesignSystem",
                "ModernMagazineLayout"
            ]
        )
    ]
)
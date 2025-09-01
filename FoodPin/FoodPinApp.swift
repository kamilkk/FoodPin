//
//  FoodPinApp.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 01/09/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

import SwiftUI

@main
struct FoodPinApp: App {
    @StateObject private var restaurantStore = RestaurantStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(restaurantStore)
        }
    }
}
//
//  Restaurant.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 01/09/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

import Foundation

struct Restaurant: Identifiable, Sendable {
    let id = UUID()
    let name: String
    let type: String
    let location: String
    let image: String
    var isVisited: Bool
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool = false) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
}

@MainActor
class RestaurantStore: ObservableObject {
    @Published private(set) var restaurants: [Restaurant] = []
    
    private let dataService = RestaurantDataService()
    
    init() {
        restaurants = dataService.getAllRestaurants()
    }
    
    func toggleVisited(for restaurant: Restaurant) {
        Task {
            var updatedRestaurant = restaurant
            updatedRestaurant.isVisited.toggle()
            
            await dataService.updateRestaurant(updatedRestaurant)
            restaurants = await dataService.getAllRestaurantsAsync()
        }
    }
    
    func deleteRestaurant(at indexSet: IndexSet) {
        Task {
            await dataService.deleteRestaurants(at: indexSet)
            restaurants = await dataService.getAllRestaurantsAsync()
        }
    }
    
    func deleteRestaurant(_ restaurant: Restaurant) {
        Task {
            await dataService.deleteRestaurant(by: restaurant.id)
            restaurants = await dataService.getAllRestaurantsAsync()
        }
    }
    
    func searchRestaurants(query: String) async -> [Restaurant] {
        return await dataService.searchRestaurants(query: query)
    }
    
    func getFavorites() async -> [Restaurant] {
        return await dataService.getFavoriteRestaurants()
    }
    
    func getGroupedByLocation() async -> [String: [Restaurant]] {
        return await dataService.getRestaurantsByLocation()
    }
}
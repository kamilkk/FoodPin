//
//  RestaurantDataService.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 01/09/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

import Foundation

actor RestaurantDataActor {
    private var restaurants: [Restaurant] = []
    
    init() {
        self.restaurants = Self.getStaticData()
    }
    
    static func getStaticData() -> [Restaurant] {
        return [
            Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Wroclaw", image: "cafedeadend"),
            Restaurant(name: "Homei", type: "Cafe", location: "Wroclaw", image: "homei"),
            Restaurant(name: "Teakha", type: "Tea House", location: "Wroclaw", image: "teakha"),
            Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Wroclaw", image: "cafeloisl"),
            Restaurant(name: "Petite Oyster", type: "French", location: "Wroclaw", image: "petiteoyster"),
            Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Wroclaw", image: "forkeerestaurant"),
            Restaurant(name: "Po's Atelier", type: "Bakery", location: "Wroclaw", image: "posatelier"),
            Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Krakow", image: "bourkestreetbakery"),
            Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Krakow", image: "haighschocolate"),
            Restaurant(name: "Palomino Espresso", type: "Italian / Seafood", location: "Krakow", image: "palominoespresso"),
            Restaurant(name: "Upstate", type: "American", location: "Szczecin", image: "upstate"),
            Restaurant(name: "Traif", type: "American", location: "Szczecin", image: "traif"),
            Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "Szczecin", image: "grahamavenuemeats"),
            Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "Szczecin", image: "wafflewolf"),
            Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "Szczecin", image: "fiveleaves"),
            Restaurant(name: "Cafe Lore", type: "Latin American", location: "Szczecin", image: "cafelore"),
            Restaurant(name: "Confessional", type: "Spanish", location: "Szczecin", image: "confessional"),
            Restaurant(name: "Barrafina", type: "Spanish", location: "Gdansk", image: "barrafina"),
            Restaurant(name: "Donostia", type: "Spanish", location: "Gdansk", image: "donostia"),
            Restaurant(name: "Royal Oak", type: "British", location: "Gdansk", image: "royaloak"),
            Restaurant(name: "Thai Cafe", type: "Thai", location: "Gdansk", image: "thaicafe")
        ]
    }
    
    func getAllRestaurants() -> [Restaurant] {
        return restaurants
    }
    
    func getRestaurant(by id: UUID) -> Restaurant? {
        return restaurants.first { $0.id == id }
    }
    
    func updateRestaurant(_ restaurant: Restaurant) {
        if let index = restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            restaurants[index] = restaurant
        }
    }
    
    func deleteRestaurant(by id: UUID) {
        restaurants.removeAll { $0.id == id }
    }
    
    func deleteRestaurants(at offsets: IndexSet) {
        restaurants.remove(atOffsets: offsets)
    }
    
    func addRestaurant(_ restaurant: Restaurant) {
        restaurants.append(restaurant)
    }
    
    func searchRestaurants(query: String) -> [Restaurant] {
        if query.isEmpty {
            return restaurants
        }
        
        return restaurants.filter { restaurant in
            restaurant.name.localizedCaseInsensitiveContains(query) ||
            restaurant.type.localizedCaseInsensitiveContains(query) ||
            restaurant.location.localizedCaseInsensitiveContains(query)
        }
    }
    
    func getRestaurantsByLocation() -> [String: [Restaurant]] {
        return Dictionary(grouping: restaurants) { $0.location }
    }
    
    func getFavoriteRestaurants() -> [Restaurant] {
        return restaurants.filter { $0.isVisited }
    }
}

@MainActor
class RestaurantDataService: ObservableObject {
    private let dataActor = RestaurantDataActor()
    
    func getAllRestaurants() -> [Restaurant] {
        return RestaurantDataActor.getStaticData()
    }
    
    func getAllRestaurantsAsync() async -> [Restaurant] {
        await dataActor.getAllRestaurants()
    }
    
    func getRestaurant(by id: UUID) async -> Restaurant? {
        await dataActor.getRestaurant(by: id)
    }
    
    func updateRestaurant(_ restaurant: Restaurant) async {
        await dataActor.updateRestaurant(restaurant)
    }
    
    func deleteRestaurant(by id: UUID) async {
        await dataActor.deleteRestaurant(by: id)
    }
    
    func deleteRestaurants(at offsets: IndexSet) async {
        await dataActor.deleteRestaurants(at: offsets)
    }
    
    func addRestaurant(_ restaurant: Restaurant) async {
        await dataActor.addRestaurant(restaurant)
    }
    
    func searchRestaurants(query: String) async -> [Restaurant] {
        await dataActor.searchRestaurants(query: query)
    }
    
    func getRestaurantsByLocation() async -> [String: [Restaurant]] {
        await dataActor.getRestaurantsByLocation()
    }
    
    func getFavoriteRestaurants() async -> [Restaurant] {
        await dataActor.getFavoriteRestaurants()
    }
}
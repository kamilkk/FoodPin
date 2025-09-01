//
//  ContentView.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 01/09/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var restaurantStore: RestaurantStore
    @State private var searchText = ""
    @State private var selectedRestaurant: Restaurant?
    
    var filteredRestaurants: [Restaurant] {
        if searchText.isEmpty {
            return restaurantStore.restaurants
        } else {
            return restaurantStore.restaurants.filter { restaurant in
                restaurant.name.localizedCaseInsensitiveContains(searchText) ||
                restaurant.type.localizedCaseInsensitiveContains(searchText) ||
                restaurant.location.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Array(filteredRestaurants.enumerated()), id: \.element.id) { index, restaurant in
                        RestaurantCard(
                            restaurant: restaurant,
                            isLarge: index % 4 == 0,
                            onTap: {
                                print("Tapped restaurant: \(restaurant.name)")
                                selectedRestaurant = restaurant
                                print("Selected restaurant set to: \(selectedRestaurant?.name ?? "nil")")
                            },
                            onToggleFavorite: {
                                withAnimation(.spring()) {
                                    restaurantStore.toggleVisited(for: restaurant)
                                }
                            },
                            onDelete: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    restaurantStore.deleteRestaurant(restaurant)
                                }
                            }
                        )
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Color(.systemBackground))
            .navigationTitle("FoodPin")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search restaurants...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("All Restaurants") {
                            // Future: Filter by all
                        }
                        Button("Favorites Only") {
                            // Future: Filter by favorites
                        }
                        Button("By Location") {
                            // Future: Group by location
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .foregroundColor(.orange)
                    }
                }
            }
        }
        .sheet(item: $selectedRestaurant) { restaurant in
            RestaurantDetailView(restaurant: restaurant)
                .environmentObject(restaurantStore)
        }
    }
}
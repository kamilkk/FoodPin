//
//  RestaurantCard.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 01/09/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

import SwiftUI

struct RestaurantCard: View {
    let restaurant: Restaurant
    let isLarge: Bool
    let onTap: () -> Void
    let onToggleFavorite: () -> Void
    let onDelete: () -> Void
    
    @State private var showingActions = false
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    // Image section
                    Image(restaurant.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: isLarge ? 200 : 150)
                        .clipped()
                    
                    // Content section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(restaurant.name)
                                    .font(isLarge ? .title2 : .headline)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                
                                Text(restaurant.type)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "location.circle.fill")
                                        .foregroundColor(.orange)
                                        .font(.caption)
                                    
                                    Text(restaurant.location)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(16)
                }
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
                
                // Favorite icon
                if restaurant.isVisited {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                        .padding(8)
                        .background(Circle().fill(.ultraThinMaterial))
                        .padding(16)
                }
                
                // Action button
                Button(action: { showingActions.toggle() }) {
                    Image(systemName: "ellipsis.circle.fill")
                        .foregroundColor(.primary)
                        .font(.title2)
                        .background(Circle().fill(.ultraThinMaterial))
                }
                .padding(8)
                .opacity(showingActions ? 1 : 0.7)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .confirmationDialog("Restaurant Actions", isPresented: $showingActions) {
            Button(restaurant.isVisited ? "Remove from Favorites" : "Add to Favorites") {
                onToggleFavorite()
            }
            
            Button("Delete", role: .destructive) {
                onDelete()
            }
            
            Button("Cancel", role: .cancel) { }
        }
    }
}
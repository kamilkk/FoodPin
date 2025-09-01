//
//  RestaurantDetailView.swift
//  FoodPin
//
//  Created by Kamil Kowalski on 01/09/2025.
//  Copyright © 2025 Kamil Kowalski. All rights reserved.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @EnvironmentObject var restaurantStore: RestaurantStore
    @Environment(\.dismiss) private var dismiss
    @State private var showingShareSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Image
                    GeometryReader { geometry in
                        Image(restaurant.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            )
                    }
                    .frame(height: 300)
                    
                    // Content
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(restaurant.name)
                                        .font(.largeTitle.weight(.bold))
                                        .foregroundColor(.primary)
                                    
                                    Text(restaurant.type)
                                        .font(.title3.weight(.medium))
                                        .foregroundColor(.orange)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.spring()) {
                                        restaurantStore.toggleVisited(for: restaurant)
                                    }
                                }) {
                                    Image(systemName: restaurant.isVisited ? "heart.fill" : "heart")
                                        .font(.title)
                                        .foregroundColor(restaurant.isVisited ? .red : .secondary)
                                }
                                .scaleEffect(restaurant.isVisited ? 1.1 : 1.0)
                                .animation(.spring(), value: restaurant.isVisited)
                            }
                            
                            HStack(spacing: 8) {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.orange)
                                
                                Text(restaurant.location)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        
                        Divider()
                            .padding(.horizontal, 24)
                        
                        // Details Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Details")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.primary)
                            
                            VStack(spacing: 16) {
                                DetailRow(
                                    icon: "tag.fill",
                                    title: "Cuisine Type",
                                    value: restaurant.type
                                )
                                
                                DetailRow(
                                    icon: "location.circle.fill",
                                    title: "Location",
                                    value: restaurant.location
                                )
                                
                                DetailRow(
                                    icon: restaurant.isVisited ? "heart.fill" : "heart",
                                    title: "Status",
                                    value: restaurant.isVisited ? "Added to Favorites" : "Not visited yet"
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        // Action Buttons
                        VStack(spacing: 16) {
                            Button(action: {
                                showingShareSheet = true
                            }) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share Restaurant")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    restaurantStore.toggleVisited(for: restaurant)
                                }
                            }) {
                                HStack {
                                    Image(systemName: restaurant.isVisited ? "heart.slash.fill" : "heart.fill")
                                    Text(restaurant.isVisited ? "Remove from Favorites" : "Add to Favorites")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color(.secondarySystemBackground))
                            .foregroundColor(.primary)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32)
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                    .offset(y: -20)
                }
            }
            .ignoresSafeArea(.container, edges: .top)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                            .background(Circle().fill(.ultraThinMaterial))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingShareSheet = true }) {
                        Image(systemName: "square.and.arrow.up.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                            .background(Circle().fill(.ultraThinMaterial))
                    }
                }
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [restaurant.name, restaurant.location])
        }
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// Extension for custom corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
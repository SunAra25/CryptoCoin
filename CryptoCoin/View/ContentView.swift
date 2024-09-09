//
//  ContentView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tag = 0
    
    var body: some View {
        TabView(selection: $tag) {
            TrendingView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            
            FavoriteCoinView()
                .tabItem {
                    Image(systemName: "heart.rectangle.fill")
                }
                .tag(2)
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}


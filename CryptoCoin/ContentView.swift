//
//  ContentView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}


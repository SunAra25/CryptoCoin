//
//  TrendingView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import SwiftUI

enum Section: String, CaseIterable {
    case favorite = "My Favorite"
    case coin = "Top15 Coin"
    case nft = "Top7 NFT"
}

struct TrendingView: View {
    var body: some View {
        NavigationView {
            VStack {
                ForEach(Section.allCases, id: \.self) { section in
                    Text(section.rawValue)
                        .asSubTitle()
                }
                    
                Spacer()
            }
            .navigationTitle("Crypto Coin")
            .padding()
        }
    }
}

#Preview {
    TrendingView()
}

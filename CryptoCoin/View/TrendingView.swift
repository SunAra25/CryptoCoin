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
                    FavoriteView()
                }
                    
                Spacer()
            }
            .navigationTitle("Crypto Coin")
            .padding()
        }
    }
}

struct FavoriteView: View {
    @State private var datas: CoinDatas = []
    private var column = [GridItem(.flexible(minimum: 150))]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: column, spacing: 12) {
                ForEach(datas.prefix(3), id: \.self) { data in
                    coinCellView(data)
                }
                
                if datas.count > 3 {
                    NavigationLink(destination: ContentView()) {
                        etcView()
                    }
                }
            }
        }
    }
    
    func coinCellView(_ data: CoinDataResponse) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.1))
                .frame(width: 210)
            VStack(alignment: .leading) {
                CoinInfoView(data: data)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                Text("₩" + data.currentPrice.formatted())
                    .font(.headline)
                Text((data.isPositivePriceChange ? "+" : "") + data.priceChangePercentage)
                    .font(.footnote).bold()
                    .foregroundStyle(data.isPositivePriceChange ? .red : .blue)
            }
            .padding()
        }
        
    }
    
    func etcView() -> some View {
        Text("더보기")
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .frame(width: 210, height: 150)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray.opacity(0.1))
            }
    }
}

#Preview {
    TrendingView()
}

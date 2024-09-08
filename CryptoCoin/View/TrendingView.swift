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
            ScrollView {
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
                let infoData = CoinInfo(name: data.name, symbol: data.symbol, image: data.image)
                CoinInfoView(data: infoData, type: .large)
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

struct CoinTop15View: View {
    @State private var screenWidth: CGFloat = 0.0
    private let coins: Coins
    private var column = [GridItem(.flexible(minimum: 48)),
                          GridItem(.flexible(minimum: 48)),
                          GridItem(.flexible(minimum: 48))]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: column, spacing: 20) {
                ForEach(Array(zip(coins.indices, coins)), id: \.0) { index, data in
                    cellView(index: "\(index)", data.item)
                        .frame(width: screenWidth - 40)
                        .padding(.vertical, 8)
                }
            }
        }
        .onReadSize { size in
            screenWidth = size.width
        }
    }
    
    func cellView(index: String, _ data: Item) -> some View {
        HStack {
            Text(index)
                .font(.title3).bold()
            
            let infoData = CoinInfo(name: data.name, symbol: data.symbol, image: data.small)
            CoinInfoView(data: infoData, type: .small)
            
            Spacer()
            
            coinDataView(data.data)
        }
        .frame(height: 48)
    }
    
    func coinDataView(_ data: ItemData) -> some View {
        VStack(alignment: .trailing) {
            Text(data.formattedPrice)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.8))
            Text(data.fluctuationRange)
                .font(.caption)
                .foregroundStyle(data.isPositiveFluctuating ? .red : .blue)
        }
    }
}


#Preview {
    TrendingView()
}

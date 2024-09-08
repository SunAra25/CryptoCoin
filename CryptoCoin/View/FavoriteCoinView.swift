//
//  FavoriteCoinView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/9/24.
//

import SwiftUI

struct FavoriteCoinView: View {
    @State private var datas: CoinDatas = [CoinDataResponse(id: "", symbol: "btc", name: "Bitcoin", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 72608945, high24H: 73305464, low24H: 72060432, priceChangePercentage24H: -0.54381, ath: 98689662, athDate: "2024-04-08T12:17:13.400Z", atl: 3558634, atlDate: "2019-04-02T00:00:00.000Z", lastUpdated: "2024-09-08T13:29:07.327Z", sparklineIn7D: nil), CoinDataResponse(id: "", symbol: "btc", name: "Bitcoidn", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 72608945, high24H: 73305464, low24H: 72060432, priceChangePercentage24H: 0.42381, ath: 98689662, athDate: "2024-04-08T12:17:13.400Z", atl: 3558634, atlDate: "2019-04-02T00:00:00.000Z", lastUpdated: "2024-09-08T13:29:07.327Z", sparklineIn7D: nil),CoinDataResponse(id: "", symbol: "btc", name: "Bitcoidn", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 72608145, high24H: 73305464, low24H: 72020432, priceChangePercentage24H: 0.42381, ath: 98689661, athDate: "2024-04-08T12:17:13.400Z", atl: 3558634, atlDate: "2019-04-02T00:00:00.000Z", lastUpdated: "2024-09-08T13:29:07.327Z", sparklineIn7D: nil)]
    @State private var screenWidth: CGFloat = 361
    private var column = [GridItem(.flexible(minimum: 150)),
                          GridItem(.flexible(minimum: 150))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column, spacing: 20) {
                    ForEach(datas, id: \.self) { data in
                        coinCellView(data)
                    }
                }
                .padding()
            }
            .navigationTitle("Favorite Coin")
        }
        .onReadSize { size in
            screenWidth = size.width
        }
    }
    
    func coinCellView(_ data: CoinDataResponse) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .frame(width: (screenWidth - 32) / 2,
                       height: (screenWidth - 32) / 2)
                .asShdowShape(radius: 5)
            VStack {
                let infoData = CoinInfo(name: data.name, symbol: data.symbol, image: data.image)
                CoinInfoView(data: infoData, type: .large)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                priceView(data)
            }
            .padding()
        }
    }
    
    func priceView(_ data: CoinDataResponse) -> some View {
        VStack(alignment: .trailing) {
            Text("₩" + data.currentPrice.formatted())
                .font(.headline)
                .padding(.vertical, -4)
            Text((data.isPositivePriceChange ? "+" : "") + data.priceChangePercentage)
                .font(.footnote).bold()
                .foregroundStyle(data.isPositivePriceChange ? .red : .blue)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(data.isPositivePriceChange ? .red.opacity(0.1) : .blue.opacity(0.1))
                }
        }
        .padding(.horizontal, 2)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    FavoriteCoinView()
}

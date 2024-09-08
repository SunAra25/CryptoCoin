//
//  CoinInfoView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import SwiftUI

struct CoinInfoView: View {
    let data: CoinDataResponse
    
    init(data: CoinDataResponse) {
        self.data = data
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: data.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
            } placeholder: {
                ProgressView()
            }
            
            
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.headline).bold()
                Text(data.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    CoinInfoView(data: CoinDataResponse(id: "", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 0, high24H: 0, low24H: 0, priceChangePercentage24H: 0, ath: 0, athDate: "", atl: 0, atlDate: "", lastUpdated: "", sparklineIn7D: nil))
}

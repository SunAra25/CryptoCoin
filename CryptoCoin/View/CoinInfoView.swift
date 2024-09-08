//
//  CoinInfoView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import SwiftUI

struct CoinInfoView: View {
    let data: CoinInfo
    let type: CoinInfoType
    
    init(data: CoinInfo, type: CoinInfoType) {
        self.data = data
        self.type = type
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: data.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: type.size, height: type.size)
            } placeholder: {
                ProgressView()
            }
            
            
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(type.nameFont)
                    .fontWeight(.semibold)
                Text(data.symbol.uppercased())
                    .font(type.symbolFont)
                    .foregroundStyle(.gray)
            }
        }
    }
}

struct CoinInfo {
    let name: String
    let symbol: String
    let image: String
}

enum CoinInfoType {
    case small
    case large
    
    var size: CGFloat {
        switch self {
        case .small: 32
        case .large: 44
        }
    }
    
    var nameFont: Font {
        switch self {
        case .small: .subheadline
        case .large: .headline
        }
    }
    
    var symbolFont: Font {
        switch self {
        case .small: .caption2
        case .large: .caption
        }
    }
}

#Preview {
    CoinInfoView(data: CoinInfo(name: "Bitcoin", symbol: "btc", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"), type: CoinInfoType.large)
}

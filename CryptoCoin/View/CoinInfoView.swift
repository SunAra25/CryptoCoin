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
    let target: String?
    
    init(data: CoinInfo, type: CoinInfoType, target: String? = nil) {
        self.data = data
        self.type = type
        self.target = target
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
                if let target {
                    Text("")
                        .asHighlightText(original: data.name, target: target)
                        .font(type.nameFont)
                        .fontWeight(type.nameFontWeight)
                        .lineLimit(1)
                } else {
                    Text(data.name)
                        .font(type.nameFont)
                        .fontWeight(type.nameFontWeight)
                        .lineLimit(1)
                }
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
    case search
    
    var size: CGFloat {
        switch self {
        case .small: 32
        case .large: 44
        case .search: 32
        }
    }
    
    var nameFont: Font {
        switch self {
        case .small: .subheadline
        case .large: .headline
        case .search: .headline
        }
    }
    
    var nameFontWeight: Font.Weight {
        switch self {
        case .search: .bold
        default: .semibold
        }
    }
    
    var symbolFont: Font {
        switch self {
        case .small: .caption2
        case .large: .caption
        case .search: .footnote
        }
    }
}

#Preview {
    CoinInfoView(data: CoinInfo(name: "Bitcoin", symbol: "btc", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"), type: CoinInfoType.search, target: "bit")
}

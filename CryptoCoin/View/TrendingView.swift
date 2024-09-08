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
                    if section != .favorite || UserDefaultsManager.like.value.count > 2 {
                        Text(section.rawValue)
                            .asSubTitle()
                        SectionView(type: section)
                    }
                }
                    
                Spacer()
            }
            .navigationTitle("Crypto Coin")
            .padding()
        }
    }
}

struct SectionView: View {
    let type: Section

    init(type: Section) {
        self.type = type
    }

    var body: some View {
        switch type {
        case .favorite:
            FavoriteView()
        case .coin:
            CoinTop15View()
                .frame(minHeight: (48 + 8) * 3)
        case .nft:
            NftTop7View()
                .frame(minHeight: (48 + 8) * 3)
        }

    }
}

struct FavoriteView: View {
    @State private var datas: CoinDatas = [CoinDataResponse(id: "", symbol: "btc", name: "Bitcoin", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 72608945, high24H: 73305464, low24H: 72060432, priceChangePercentage24H: -0.54381, ath: 98689662, athDate: "2024-04-08T12:17:13.400Z", atl: 3558634, atlDate: "2019-04-02T00:00:00.000Z", lastUpdated: "2024-09-08T13:29:07.327Z", sparklineIn7D: nil)]
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
    private let coins: Coins = [
        Coin(item: Item(id: "", name: "Solana", symbol: "LTC", small: "https://coin-images.coingecko.com/coins/images/39765/small/Simon's_Cat_Logo.png?1724017505", data: ItemData(price: 54611.87939222848, priceChangePercentage24H: ["aed":0.3374130145010234,"ars":0.2701075831615574,"aud":0.32119494127191034,"bch":0.07661156119132854,"bdt":0.3361837241154364,"bhd":0.5522652917915238,"krw":4.649387061828016]))),
        Coin(item: Item(id: "", name: "Magic Square", symbol: "LTC", small: "https://coin-images.coingecko.com/coins/images/1/small/bitcoin.png?1696501400", data: ItemData(price: 54611.87939222848, priceChangePercentage24H: ["aed":0.3374130145010234,"ars":0.2701075831615574,"aud":0.32119494127191034,"bch":0.07661156119132854,"bdt":0.3361837241154364,"bhd":0.5522652917915238,"krw":4.649387061828016]))),
        Coin(item: Item(id: "", name: "Pixels", symbol: "LTC", small: "https://coin-images.coingecko.com/coins/images/1/small/bitcoin.png?1696501400", data: ItemData(price: 54611.87939222848, priceChangePercentage24H: ["aed":0.3374130145010234,"ars":0.2701075831615574,"aud":0.32119494127191034,"bch":0.07661156119132854,"bdt":0.3361837241154364,"bhd":0.5522652917915238,"krw":4.649387061828016]))),
        Coin(item: Item(id: "", name: "Torrent", symbol: "LTC", small: "https://coin-images.coingecko.com/coins/images/1/small/bitcoin.png?1696501400", data: ItemData(price: 54611.87939222848, priceChangePercentage24H: ["aed":0.3374130145010234,"ars":0.2701075831615574,"aud":0.32119494127191034,"bch":0.07661156119132854,"bdt":0.3361837241154364,"bhd":0.5522652917915238,"krw":4.649387061828016])))
    ]
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

struct NftTop7View: View {
    @State private var screenWidth: CGFloat = 0.0
    private let nfts: Nfts = [Nft(id: "", name: "Kanpai Pandas", symbol: "YKPS", thumb: "https://coin-images.coingecko.com/nft_contracts/images/1554/standard/kanpai-pandas.png?1707287899", data: NftData(floorPrice: "0,54 ETH", floorPriceInUsd24HPercentageChange: "17.4711348506424", sparkline: "")), Nft(id: "", name: "Wrapped Cryptopunks", symbol: "WPUNKS", thumb: "https://coin-images.coingecko.com/nft_contracts/images/934/standard/wrapped-cryptopunks.png?1707287572", data: NftData(floorPrice: "31,85 ETH", floorPriceInUsd24HPercentageChange: "11.9801906828425", sparkline: "")), Nft(id: "", name: "Moonbirds", symbol: "MOONBIRD", thumb: "https://coin-images.coingecko.com/nft_contracts/images/349/standard/moobirds.webp?1719455973", data: NftData(floorPrice: "0,40 ETH", floorPriceInUsd24HPercentageChange: "8.78902249157555", sparkline: "")), Nft(id: "", name: "Chimpers", symbol: "CHIMP", thumb: "https://coin-images.coingecko.com/nft_contracts/images/388/standard/chimpers.gif?1707287295", data: NftData(floorPrice: "0,44 ETH", floorPriceInUsd24HPercentageChange: "8.6116440207459", sparkline: ""))]
    private var column = [GridItem(.flexible(minimum: 48)),
                          GridItem(.flexible(minimum: 48)),
                          GridItem(.flexible(minimum: 48))]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: column, spacing: 20) {
                ForEach(Array(zip(nfts.indices, nfts)), id: \.0) { index, data in
                    cellView(index: "\(index)", data)
                        .frame(width: screenWidth - 40)
                        .padding(.vertical, 8)
                }
            }
        }
        .onReadSize { size in
            screenWidth = size.width
        }
    }
    
    func cellView(index: String, _ data: Nft) -> some View {
        HStack {
            Text(index)
                .font(.title3).bold()
            
            let infoData = CoinInfo(name: data.name, symbol: data.symbol, image: data.thumb)
            CoinInfoView(data: infoData, type: .small)
            
            Spacer()
            
            coinDataView(data.data)
        }
        .frame(height: 48)
    }
    
    func coinDataView(_ data: NftData) -> some View {
        VStack(alignment: .trailing) {
            Text(data.floorPrice)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.8))
            Text(data.fluctuationPercent)
                .font(.caption)
                .foregroundStyle(data.isPositiveFluctuating ? .red : .blue)
        }
    }
}


#Preview {
    TrendingView()
}

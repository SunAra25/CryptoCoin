//
//  SearchView.swift
//  CryptoCoin
//
//  Created by 아라 on 9/9/24.
//

import SwiftUI

struct SearchView: View {
    @State private var input = ""
    @State private var resultList: [CoinResult] = []
    @State private var filterList: [CoinResult] = []
    @State private var likeList: Set<String> = UserDefaultsManager.like.value
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach($filterList, id: \.self) { data in
                        let infoData = CoinInfo(name: data.name.wrappedValue, symbol: data.symbol.wrappedValue, image: data.thumb.wrappedValue)
                        let id = data.id.wrappedValue
                        HStack {
                            CoinInfoView(data: infoData, type: .search, target: input)
                            Spacer()
                            Button {
                                if likeList.contains(where: { $0 == id }) {
                                    likeList.remove(id)
                                } else {
                                    likeList.insert(id)
                                }
                            } label: {
                                Image(systemName: likeList.contains(where: { $0 == id }) ? "star.fill" : "star")
                                    .foregroundStyle(.purple)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $input)
            .onChange(of: input) { newValue in
                if newValue.isEmpty {
                    filterList = []
                }
            }
            .onSubmit(of: .search) {
                resultList = [
                    CoinResult(id: "bitcoin", name: "Bitcoin", symbol: "btc", thumb: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"),
                    CoinResult(id: "wrapped-bitcoin", name: "Wrapped Bitcoin difjifjjd bitconin dijfjie", symbol: "wbtc", thumb: "https://coin-images.coingecko.com/coins/images/7598/large/wrapped_bitcoin_wbtc.png?1696507857")
                ]
                
                filterList = resultList.filter { $0.name.lowercased().contains(input.lowercased()) }
            }
            .onDisappear {
                UserDefaultsManager.like.value = likeList
            }
        }
    }
}

#Preview {
    SearchView()
}

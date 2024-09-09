//
//  SearchResponse.swift
//  CryptoCoin
//
//  Created by 아라 on 9/9/24.
//

import Foundation

struct SearchResponse: Decodable {
    let coins: [CoinResult]
}

struct CoinResult: Decodable, Hashable {
    var id, name, symbol: String
    var thumb: String
}

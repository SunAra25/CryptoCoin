//
//  TrendingResponse.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import Foundation

typealias Coins = [Coin]
typealias Nfts = [Nft]

struct TrendingResponse: Decodable {
    let coins: [Coin]
    let nfts: [Nft]
}

struct Coin: Decodable, Hashable {
    let item: Item
}

struct Item: Decodable, Hashable {
    let id: String
    let name, symbol: String
    let small: String
    let data: ItemData

}

struct ItemData: Decodable, Hashable {
    let price: Double
    let priceChangePercentage24H: [String: Double]
    
    var formattedPrice: String {
        let dollar = price * 0.75
        return "$" + String(format: "%.2f", dollar)
    }
    
    var fluctuationRange: String {
        guard let data = priceChangePercentage24H["krw"] else { return "" }
        let dataString = String(format: "%.2f", data) + "%"
        return (data > 0 ? "+" : "") + dataString
    }
    
    var isPositiveFluctuating: Bool {
        guard let data = priceChangePercentage24H["krw"] else { return false }
        return data >= 0
    }
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}


struct Nft: Decodable, Hashable {
    let id, name, symbol: String
    let thumb: String
    let data: NftData
}

struct NftData: Decodable, Hashable {
    let floorPrice, floorPriceInUsd24HPercentageChange: String
    let sparkline: String

    var fluctuationPercent: String {
        guard let data = Double(floorPriceInUsd24HPercentageChange) else { return "" }
        return String(format: "%.2f", data)
    }
    
    var isPositiveFluctuating: Bool {
        guard let data = Double(fluctuationPercent) else { return false }
        return data >= 0
    }
    
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case sparkline
    }
}

//
//  CoinDataResponse.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import Foundation

typealias CoinDatas = [CoinDataResponse]

struct CoinDataResponse: Decodable, Hashable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Int
    let high24H, low24H: Int
    let priceChangePercentage24H: Double
    let ath: Int
    let athDate: String
    let atl: Double
    let atlDate: String
    let lastUpdated: String
    let sparklineIn7D: SparklineIn7D?
    
    var priceChangePercentage: String {
        return String(format: "%.2f", priceChangePercentage24H) + "%"
    }
    var isPositivePriceChange: Bool {
        return priceChangePercentage24H >= 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case ath
        case athDate = "ath_date"
        case atl
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
    }
}

struct SparklineIn7D: Decodable, Hashable {
    let price: [Double]
}

//
//  CoinDto.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 9/03/24.
//

// CoinGEcko API Info
/*
 URL:
 https://api.coingecko.com/api/v3/coins/markets?vs_Jurrency=usd&order-market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h

 JsonResponse:
 [
 {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
 "current_price": 68304,
 "market_cap": 1342165404759,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 1434405389790,
 "total_volume": 32145112025,
 "high_24h": 69428,
 "low_24h": 68053,
 "price_change_24h": 17.24,
 "price_change_percentage_24h": 0.02525,
 "market_cap_change_24h": -5200411973.437256,
 "market_cap_change_percentage_24h": -0.38597,
 "circulating_supply": 19649587,
 "total_supply": 21000000,
 "max_supply": 21000000,
 "ath": 69428,
 "ath_change_percentage": -1.67264,
 "ath_date": "2024-03-08T20:05:03.481Z",
 "atl": 67.81,
 "atl_change_percentage": 100574.60974,
 "atl_date": "2013-07-06T00:00:00.000Z",
 "roi": null,
 "last_updated": "2024-03-09T18:07:44.399Z",
 "price_change_percentage_24h_in_currency": 0.02524551833345361
 }]
 */

import Foundation

struct CoinDto: Codable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice: Double?
    let marketCap, marketCapRank: Double?
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double?
    let totalSupply, maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7DDto?
    let priceChangePercentage24HInCurrency: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    }
}

struct SparklineIn7DDto: Codable {
    let price: [Double]?
}

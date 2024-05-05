//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 9/03/24.
//

import Foundation

struct CoinModel: Identifiable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let currentPriceString: String
    let marketCap: Double?
    let marketCapRank: Double
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24H, low24H, priceChange24H: Double
    let priceChangePercentage24H: Double
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply: Double?
    let totalSupply, maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D
    let priceChangePercentage24HInCurrency: Double
    var currentHoldings: Double? = nil

    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            currentPriceString: currentPriceString,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24H: high24H,
            low24H: low24H,
            priceChange24H: priceChange24H,
            priceChangePercentage24H: priceChangePercentage24H,
            marketCapChange24H: marketCapChange24H,
            marketCapChangePercentage24H: marketCapChangePercentage24H,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            lastUpdated: lastUpdated,
            sparklineIn7D: sparklineIn7D,
            priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
            currentHoldings: amount
        )
    }

    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0.0 ) *  currentPrice
    }

    var rank: Int {
        return Int(marketCapRank)
    }
}

struct SparklineIn7D {
    let price: [Double]

    init(price: [Double]? = []) {
        self.price = price ?? []
    }
}

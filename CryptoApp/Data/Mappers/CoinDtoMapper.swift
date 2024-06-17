//
//  CoinDtoMapper.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 10/03/24.
//

import Foundation

struct CoinDtoMapper {
    let sparklineMapper: SparklineDtoMapper

    func mapToDomainModel(from model: CoinDto) -> CoinModel? {
        guard let id = model.id,
              let symbol = model.symbol,
              let name = model.name,
              let image = model.image,
              let currentPrice = model.currentPrice
        else { return nil }

        var sparklineIn7D = SparklineIn7D()
        if let sparkline = model.sparklineIn7D {
            sparklineIn7D = sparklineMapper.mapToDomainModel(from: sparkline)
        }

        return CoinModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            currentPriceString: currentPrice.asCurrencyWith2Decimals(),
            marketCap: model.marketCap,
            marketCapRank: model.marketCapRank ?? 0.0,
            fullyDilutedValuation: model.fullyDilutedValuation,
            totalVolume: model.totalVolume,
            high24H: model.high24H,
            low24H: model.low24H,
            priceChange24H: model.priceChange24H,
            priceChangePercentage24H: model.priceChangePercentage24H ?? 0.0,
            marketCapChange24H: model.marketCapChange24H,
            marketCapChangePercentage24H: model.marketCapChangePercentage24H,
            circulatingSupply: model.circulatingSupply,
            totalSupply: model.totalSupply,
            maxSupply: model.maxSupply,
            ath: model.ath,
            athChangePercentage: model.athChangePercentage,
            athDate: model.athDate,
            atl: model.atl,
            atlChangePercentage: model.atlChangePercentage,
            atlDate: model.atlDate,
            lastUpdated: model.lastUpdated,
            sparklineIn7D: sparklineIn7D,
            priceChangePercentage24HInCurrency: model.priceChangePercentage24HInCurrency ?? 0.0
            //currentHoldings: 0.0
        )
    }
}

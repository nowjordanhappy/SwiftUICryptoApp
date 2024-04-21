//
//  MarketDataDtoMapper.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 21/04/24.
//

import Foundation

struct MarketDataDtoMapper {

    func mapToDomainModel(from model: MarketDataDto) -> MarketDataModel? {
        guard let totalMarketCap = model.totalMarketCap,
              let totalVolume = model.totalVolume,
              let marketCapPercentage = model.marketCapPercentage,
              let marketCapChangePercentage24HUsd = model.marketCapChangePercentage24HUsd
        else { return nil }

        return MarketDataModel(
            totalMarketCap: totalMarketCap,
            totalVolume: totalVolume,
            marketCapPercentage: marketCapPercentage,
            marketCapChangePercentage24HUsd: marketCapChangePercentage24HUsd
        )
    }
}

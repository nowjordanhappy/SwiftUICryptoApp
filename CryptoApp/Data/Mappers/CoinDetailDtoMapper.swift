//
//  CoindDetailDtoMapper.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 15/06/24.
//

import Foundation

struct CoindDetailDtoMapper {
    func mapToDomainModel(from model: CoinDetailDto) -> CoinDetailModel? {
        guard let id = model.id,
              let symbol = model.symbol,
              let name = model.name
        else { return nil }

        return CoinDetailModel(
            id: id, 
            symbol: symbol,
            name: name,
            blockTimeInMinutes: model.blockTimeInMinutes, 
            hashingAlgorithm: model.hashingAlgorithm,
            description: mapDescriptionToDomainModel(from: model.description),
            links: mapLinkToDomainModel(from: model.links))
    }

    private func mapLinkToDomainModel(from model: LinksDto?) -> Links? {
        guard let model = model else { return nil }
        return Links(homepage: model.homepage ?? [], subredditURL: model.subredditURL)
    }

    private func mapDescriptionToDomainModel(from model: DescriptionDto?) -> Description? {
        guard let model = model else { return nil }
        return Description(en: model.en)
    }
}

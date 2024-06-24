//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 21/04/24.
//

import Foundation
import Combine

class MarketDataService {
    let networkingManager: NetworkingManager
    let mapper: MarketDataDtoMapper

    @Published var marketData: MarketDataModel?

    var marketDataSubscription: AnyCancellable?

    init(networkingManager: NetworkingManager, mapper: MarketDataDtoMapper) {
        self.networkingManager = networkingManager
        self.mapper = mapper
        getData()
    }

    func getData() {
        debugPrint("getData")
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }

        //marketDataSubscription = networkingManager.download(url: url) // uncomment to load from API
        marketDataSubscription = networkingManager.readLocalJSON(nameFile: "marketDataResponse") // uncomment to load from local json
            .decode(type: GlobalDataDto.self, decoder: JSONDecoder())
            .map { globalDataDto in
                if let data = globalDataDto.data {
                    return self.mapper.mapToDomainModel(from: data)
                } else {
                    return nil
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkingManager.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedmarketData in
                self?.marketData = returnedmarketData
                self?.marketDataSubscription?.cancel()
            })
    }
}

//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 12/03/24.
//

import Foundation
import Combine

class CoinDataService {
    let networkingManager: NetworkingManager
    let mapper: CoinDtoMapper

    @Published var allCoins: [CoinModel] = []

    var coinSubscription: AnyCancellable?

    init(networkingManager: NetworkingManager, mapper: CoinDtoMapper) {
        self.networkingManager = networkingManager
        self.mapper = mapper
        getCoins()
    }

    private func getCoins() {
        debugPrint("getCoins")
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order-market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else { return }

        //coinSubscription = networkingManager.download(url: url)
        coinSubscription = networkingManager.readLocalJSON(nameFile: "marketsResponse")
            .decode(type: [CoinDto].self, decoder: JSONDecoder())
            .map { coinsDto in
                debugPrint("getCoins coinsDto \(coinsDto.count)")
                return coinsDto.compactMap { self.mapper.mapToDomainModel(from: $0) }
            }
            .sink(receiveCompletion: networkingManager.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedCoins in
                debugPrint("getCoins returnedCoins \(returnedCoins.count)")
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}

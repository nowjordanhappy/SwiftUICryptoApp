//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 15/06/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    let networkingManager: NetworkingManager
    let mapper: CoindDetailDtoMapper

    @Published var coinDetails: CoinDetailModel?

    var coinDetailsSubscription: AnyCancellable?
    let coin: CoinModel

    init(coin: CoinModel, networkingManager: NetworkingManager, mapper: CoindDetailDtoMapper) {
        self.coin = coin
        self.networkingManager = networkingManager
        self.mapper = mapper
        getCoinDetails()
    }

    func getCoinDetails() {
        debugPrint("getCoinDetails")
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }

        //coinSubscription = networkingManager.download(url: url) // uncomment to load from api
        coinDetailsSubscription = networkingManager.readLocalJSON(nameFile: "bitcoinDetailResponse") // uncomment to load from local json
            .decode(type: CoinDetailDto.self, decoder: JSONDecoder())
            .map { coinDetailDto in
                return self.mapper.mapToDomainModel(from: coinDetailDto)
            }
            .sink(receiveCompletion: networkingManager.handleCompletion(completion:), receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailsSubscription?.cancel()
            })
    }
}

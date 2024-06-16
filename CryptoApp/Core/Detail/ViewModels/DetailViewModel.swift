//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 15/06/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    private let networkingManager: NetworkingManager
    private let coinDetailService: CoinDetailDataService

    init(coin: CoinModel) {
        networkingManager = NetworkingManager()
        coinDetailService = CoinDetailDataService(coin: coin, networkingManager: networkingManager, mapper: CoindDetailDtoMapper())
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("RECEIVED COIN DETAIL DATA")
            }
            .store(in: &cancellables)
    }
}

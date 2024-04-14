//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 12/03/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""

    private let networkingManager: NetworkingManager
    private let sparklineMapper: SparklineDtoMapper
    private let coinMapper: CoinDtoMapper
    private let dataService: CoinDataService

    private var cancellables = Set<AnyCancellable>()

    init() {
        sparklineMapper = SparklineDtoMapper()
        coinMapper = CoinDtoMapper(sparklineMapper: sparklineMapper)
        networkingManager = NetworkingManager()
        dataService = CoinDataService(networkingManager: networkingManager, mapper: coinMapper)

        addSubscribers()
    }

    func addSubscribers() {
        //        dataService.$allCoins
        //            .sink { [weak self] returnedCoins in
        //                self?.allCoins = returnedCoins
        //                debugPrint("getCoins VM returnedCoins \(returnedCoins.count)")
        //            }
        //            .store(in: &cancellables)

        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoin)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }

    private func filterCoin(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()

        return  coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}

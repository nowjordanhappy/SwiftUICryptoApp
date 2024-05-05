//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 12/03/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []


    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""

    private let networkingManager: NetworkingManager
    private let sparklineMapper: SparklineDtoMapper
    private let coinMapper: CoinDtoMapper
    private let marketDataMapper: MarketDataDtoMapper
    private let coinDataService: CoinDataService
    private let marketDataService: MarketDataService
    private let portfolioDataService: PortfolioDataService

    private var cancellables = Set<AnyCancellable>()

    init() {
        sparklineMapper = SparklineDtoMapper()
        coinMapper = CoinDtoMapper(sparklineMapper: sparklineMapper)
        marketDataMapper = MarketDataDtoMapper()
        networkingManager = NetworkingManager()
        coinDataService = CoinDataService(networkingManager: networkingManager, mapper: coinMapper)
        marketDataService = MarketDataService(networkingManager: networkingManager, mapper: marketDataMapper)
        portfolioDataService = PortfolioDataService()

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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoin)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)

        // update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$saveEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { coin -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }

    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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

    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        guard let data = marketDataModel else {
            return stats
        }

        let marketCap = StatisticModel(title: LocalizableKeys.marketCap, value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)

        let volume = StatisticModel(title: LocalizableKeys.volume24H, value: data.volume)

        let btcDominance = StatisticModel(title: LocalizableKeys.btcDominance, value: data.btcDominance)

        let portfolio = StatisticModel(title: LocalizableKeys.portfolioValue, value: "$0.00", percentageChange: 0)

        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}

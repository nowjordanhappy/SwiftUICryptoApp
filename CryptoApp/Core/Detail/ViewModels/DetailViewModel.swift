//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 15/06/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    @Published var coin: CoinModel

    private var cancellables = Set<AnyCancellable>()

    private let networkingManager: NetworkingManager
    private let coinDetailService: CoinDetailDataService

    init(coin: CoinModel) {
        self.coin = coin
        self.networkingManager = NetworkingManager()
        self.coinDetailService = CoinDetailDataService(coin: coin, networkingManager: networkingManager, mapper: CoindDetailDtoMapper())
        self.addSubscribers()
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink {  [weak self] (returnedArrays) in
                print("RECEIVED COIN DETAIL DATA")
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)

        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }

    private func mapDataToStatistics(coinDatailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overviewArray: [StatisticModel] = createOverviewArray(coinModel: coinModel)
        let additionalArray: [StatisticModel] = createAdditionalArray(coinDatailModel: coinDatailModel, coinModel: coinModel)
        print("overviewArray count: \(overviewArray.count)")
        print("additionalArray count: \(additionalArray.count)")

        return (overviewArray, additionalArray)
    }

    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith2Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: .currentPrice, value: price, percentageChange: pricePercentChange)

        let marketCap = CurrencyUtil.instance.currencySymbol + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: .marketCapitalization, value: marketCap, percentageChange: marketCapPercentageChange)

        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: .rank, value: rank)

        let volume =  CurrencyUtil.instance.currencySymbol + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: .volume, value: volume)

        return [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
    }

    private func createAdditionalArray(coinDatailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        let high = (coinModel.high24H ?? 0) > 10 ? coinModel.high24H?.asCurrencyWith2Decimals() ?? "N/A" : coinModel.high24H?.asCurrencyWith6Decimals() ?? "N/A"
        let highStat = StatisticModel(title: .high24H, value: high)

        let low = (coinModel.low24H ?? 0) > 10 ? coinModel.low24H?.asCurrencyWith2Decimals() ?? "N/A" : coinModel.low24H?.asCurrencyWith6Decimals() ?? "N/A"
        let lowStat = StatisticModel(title: .low24H, value: low)

        let priceChange = (coinModel.priceChange24H ?? 0) > 10 ? coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "N/A" : coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "N/A"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: .priceChange24H, value: priceChange, percentageChange: pricePercentChange)

        let marketCapChange =  CurrencyUtil.instance.currencySymbol + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: .marketCapChange24H, value: marketCapChange, percentageChange: marketCapPercentChange)

        let blockTime = coinDatailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
        let blockTimeStat = StatisticModel(title: .blockTime, value: blockTimeString)

        let hashingAlgo = coinDatailModel?.hashingAlgorithm ?? "N/A"
        let hashingAlgoStat = StatisticModel(title: .hashingAlgorithm, value: hashingAlgo)

        return [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingAlgoStat
        ]
    }
}

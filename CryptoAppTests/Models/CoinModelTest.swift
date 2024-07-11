//
//  CoinModelTest.swift
//  CryptoAppTests
//
//  Created by Jordan Rojas Alarcon on 29/06/24.
//

import XCTest
@testable import CryptoApp

final class CoinModelTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_updateHoldings_setsCurrentHoldingsCorrectly() throws {
        let coin = CoinModel(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, currentPriceString: "$61,408.00", marketCap: 1141731099010, marketCapRank: 1, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 6.87944, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7D(price: nil), priceChangePercentage24HInCurrency: 3952.64)

        let updatedCoind = coin.updateHoldings(amount: 10.0)

        XCTAssertEqual(updatedCoind.currentHoldings, 10.0)
    }

    func test_updateHoldingsValue_calculatesCorrectly() throws {
        let coin = CoinModel(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, currentPriceString: "$61,408.00", marketCap: 1141731099010, marketCapRank: 1, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 6.87944, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7D(price: nil), priceChangePercentage24HInCurrency: 3952.64)

        let updatedCoin = coin.updateHoldings(amount: 10.0)

        XCTAssertEqual(updatedCoin.currentHoldingsValue, 10.0 * updatedCoin.currentPrice)
    }

    func test_currentHoldingsValue_withNilCurrentHoldings_returnsZero() throws {
        let coin = CoinModel(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, currentPriceString: "$61,408.00", marketCap: 1141731099010, marketCapRank: 1, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 6.87944, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7D(price: nil), priceChangePercentage24HInCurrency: 3952.64)

        XCTAssertEqual(coin.currentHoldingsValue, 0)
    }

    func test_rank_convertsMarketCapRankCorrectly() throws {
        let coin = CoinModel(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, currentPriceString: "$61,408.00", marketCap: 1141731099010, marketCapRank: 1, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 6.87944, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7D(price: nil), priceChangePercentage24HInCurrency: 3952.64)

        let updatedCoin = coin.updateHoldings(amount: 10.0)

        XCTAssertEqual(updatedCoin.rank, Int(coin.marketCapRank))
    }
}

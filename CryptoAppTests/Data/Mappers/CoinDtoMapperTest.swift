//
//  CoinDtoMapperTest.swift
//  CryptoAppTests
//
//  Created by Jordan Rojas Alarcon on 29/06/24.
//

import XCTest
@testable import CryptoApp

final class CoinDtoMapperTest: XCTestCase {
    var sparklineMapper: SparklineDtoMapper!
    var mapper: CoinDtoMapper!

    override func setUpWithError() throws {
        sparklineMapper = SparklineDtoMapper()
        mapper = CoinDtoMapper(sparklineMapper: sparklineMapper)
    }

    override func tearDownWithError() throws {
        mapper = nil
        sparklineMapper = nil
    }

    func test_mapToDomainModel_withCompleteData_shouldMapCorrectly() throws {
        let dto = CoinDto(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, marketCap: 1141731099010, marketCapRank: 1, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 6.87944, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7DDto(price: []), priceChangePercentage24HInCurrency: 3952.64)

        let expected = CoinModel(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, currentPriceString: "$61,408.00", marketCap: 1141731099010, marketCapRank: 1, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 6.87944, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7D(price: nil), priceChangePercentage24HInCurrency: 3952.64)

        let actual = mapper.mapToDomainModel(from: dto)

        XCTAssertNotNil(actual)
        XCTAssertEqual(expected.id, actual!.id)
        XCTAssertEqual(expected.symbol, actual!.symbol)
        XCTAssertEqual(expected.name, actual!.name)
        XCTAssertEqual(expected.rank, actual!.rank)
        XCTAssertEqual(expected.currentPriceString, actual!.currentPriceString)
        XCTAssertNil(actual!.currentHoldings)
        XCTAssertEqual(expected.currentHoldings, actual!.currentHoldings)
    }

    func test_mapToDomainModel_withMissingOptionalValues_shouldMapCorrectly() throws {
        let dto = CoinDto(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, marketCap: 1141731099010, marketCapRank: nil, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: nil, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7DDto(price: []), priceChangePercentage24HInCurrency: nil)

        let expected = CoinModel(id: "bitcoin", symbol: "BTC", name: "bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 61408, currentPriceString: "$61,408.00", marketCap: 1141731099010, marketCapRank: 0.0, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 0.0, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 0, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7D(price: nil), priceChangePercentage24HInCurrency: 0.0)

        let actual = mapper.mapToDomainModel(from: dto)

        XCTAssertNotNil(actual)
        XCTAssertEqual(expected.id, actual!.id)
        XCTAssertEqual(expected.symbol, actual!.symbol)
        XCTAssertEqual(expected.name, actual!.name)
        XCTAssertEqual(expected.rank, actual!.rank)
        XCTAssertEqual(0.0, actual!.marketCapRank)
        XCTAssertEqual(expected.marketCapRank, actual!.marketCapRank)
        XCTAssertEqual(0.0, actual!.priceChangePercentage24H)
        XCTAssertEqual(expected.priceChangePercentage24H, actual!.priceChangePercentage24H)
        XCTAssertEqual(0.0, actual!.priceChangePercentage24HInCurrency)
        XCTAssertEqual(expected.priceChangePercentage24HInCurrency, actual!.priceChangePercentage24HInCurrency)
    }

    func test_mapToDomainModel_withAllNilValues_shouldReturnNil() throws {
        let dto = CoinDto(id: nil, symbol: nil, name: nil, image: nil, currentPrice: nil, marketCap: 1141731099010, marketCapRank: 1, fullyDilutedValuation: 1285385611303, totalVolume: 67190952980, high24H: 61712, low24H: 56220, priceChange24H: 3952.64, priceChangePercentage24H: 6.87944, marketCapChange24H: 72110681879, marketCapChangePercentage24H: 6.74171, circulatingSupply: 18653043, totalSupply: 21000000, maxSupply: 21000000, ath: 61712, athChangePercentage: -0.97589, athDate: "2021-03-13T20:49:26.606Z", atl: 67.81, atlChangePercentage: 90020.24075, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-03-13T23:18:10.268Z", sparklineIn7D: SparklineIn7DDto(price: []), priceChangePercentage24HInCurrency: 3952.64)

        let actual = mapper.mapToDomainModel(from: dto)

        XCTAssertNil(actual)
    }
}

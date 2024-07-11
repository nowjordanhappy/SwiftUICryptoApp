//
//  SparklineDtoMapperTest.swift
//  CryptoAppTests
//
//  Created by Jordan Rojas Alarcon on 29/06/24.
//

import XCTest
@testable import CryptoApp

final class SparklineDtoMapperTest: XCTestCase {
    var mapper: SparklineDtoMapper!

    override func setUpWithError() throws {
        mapper = SparklineDtoMapper()
    }

    override func tearDownWithError() throws {
        mapper = nil
    }

    func test_mapToDomainModel_withNonEmptyPrices_shouldMapCorrectly() throws {
        let dto = SparklineIn7DDto(price: [1.0, 0.20, 3.00])
        let expected = SparklineIn7D(price: dto.price)

        let actual = mapper.mapToDomainModel(from: dto)

        XCTAssertFalse(actual.price.isEmpty)
        XCTAssertEqual(expected.price.count, actual.price.count)
        XCTAssertEqual(expected.price, actual.price)
    }

    func test_mapToDomainModel_withNilPrices_shouldReturnEmptyArray() throws {
        let dto = SparklineIn7DDto(price: nil)
        let expected = SparklineIn7D(price: [])

        let actual = mapper.mapToDomainModel(from: dto)

        XCTAssertTrue(actual.price.isEmpty)
        XCTAssertEqual(expected.price, actual.price)
    }

    func test_mapToDomainModel_withEmptyPrices_shouldReturnEmptyArray() throws {
        let dto = SparklineIn7DDto(price: [])
        let expected = SparklineIn7D(price: [])

        let actual = mapper.mapToDomainModel(from: dto)

        XCTAssertTrue(actual.price.isEmpty)
        XCTAssertEqual(expected.price, actual.price)
    }
}

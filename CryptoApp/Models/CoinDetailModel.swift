//
//  CoinDetailModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 15/06/24.
//

import Foundation

struct CoinDetailModel {
    let id, symbol, name: String
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?

    var readableDescription: String? {
        //return description?.en?.removingHTMLOccurances
        return description?.en//?.removingHTMLOccurances
    }
}

struct Links {
    let homepage: [String]
    let subredditURL: String?
}

struct Description {
    let en: String?
}

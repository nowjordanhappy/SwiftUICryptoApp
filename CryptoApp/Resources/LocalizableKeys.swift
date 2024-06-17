//
//  LocalizableKeys.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import Foundation
import SwiftUI

enum LocalizableKeys : String {
    case livePrices = "livePrices"
    case portfolio = "portfolio"
    case coin = "coin"
    case holdings = "holdings"
    case price = "price"
    case searchPlaceholder = "searchPlaceholder"
    case marketCap = "marketCap"
    case volume24H
    case btcDominance
    case portfolioValue
    case usd
    case dolarSign
    case editPortfolio
    case currentPriceOf = "currentPriceOf %@"
    case amountInPortfolio
    case save
    case currentValue
    case currentPrice
    case quantityPlaceholder
    case marketCapitalization
    case rank
    case volume
    case high24H
    case low24H
    case priceChange24H
    case marketCapChange24H
    case blockTime
    case hashingAlgorithm
    case overview
    case additionalDetails

    var localizedStringKey: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }

    func getLocalizedString(_ arguments: any CVarArg...) -> String{
        return String(format: NSLocalizedString(self.rawValue, comment: ""), arguments: arguments)
    }
}

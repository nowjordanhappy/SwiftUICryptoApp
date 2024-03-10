//
//  Currency.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 10/03/24.
//

import Foundation

struct CurrencyUtil {
    static let instance = CurrencyUtil()
    private init() {}

    let currencyCode = "usd"
    let currencySymbol = "$"
    let minimumFractionDigits = 2
    let maximumFractionDigits = 2
    let defaultCurrenyValue = "0.00"
}

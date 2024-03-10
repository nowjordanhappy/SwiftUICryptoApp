//
//  Double.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 10/03/24.
//

import Foundation

extension Double {
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 0.123456 to $0.12
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = CurrencyUtil.instance.currencyCode
        formatter.currencySymbol = CurrencyUtil.instance.currencySymbol
        formatter.minimumFractionDigits = CurrencyUtil.instance.minimumFractionDigits
        formatter.maximumFractionDigits = CurrencyUtil.instance.maximumFractionDigits
        return formatter
    }

    /// Converts a Double into a Currency as a String with 2 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ??
        "\(CurrencyUtil.instance.currencySymbol)\(CurrencyUtil.instance.defaultCurrenyValue)"
    }

    /// Converts a Double into string representation
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }

    /// Converts a Double into string representation with percent symbol
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}

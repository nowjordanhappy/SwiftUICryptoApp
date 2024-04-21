//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 14/04/24.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: LocalizableKeys
    let value: String
    let percentageChange: Double?

    init(title: LocalizableKeys, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

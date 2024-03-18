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

    var localizedString: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
}

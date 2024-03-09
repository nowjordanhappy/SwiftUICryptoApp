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

    var localizedString: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
}

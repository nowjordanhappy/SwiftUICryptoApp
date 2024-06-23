//
//  String.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 22/06/24.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

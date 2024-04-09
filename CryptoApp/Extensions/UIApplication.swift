//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/04/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

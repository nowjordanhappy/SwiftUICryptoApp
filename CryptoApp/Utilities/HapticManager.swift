//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 9/05/24.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

//
//  GrowingButton.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 11/07/24.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    let color: Color
    let textColor: Color

    init(color: Color = Color.theme.accent, textColor: Color = Color.theme.primaryText) {
        self.color = color
        self.textColor = textColor
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(color)
            .foregroundStyle(textColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.15 : 1)
                        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

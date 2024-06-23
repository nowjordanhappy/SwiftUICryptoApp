//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

struct CircleButtonView: View {

    let icon: SystemIcon

    var body: some View {
        Image(systemIcon: icon)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50, alignment: .center)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10,
                x: 0,
                y: 0
            )
            .padding()
    }
}

#Preview {
    CircleButtonView(icon: SystemIcon.info)
        .previewLayout(.sizeThatFits)
}

#Preview {
    CircleButtonView(icon: SystemIcon.plus)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}

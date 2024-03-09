//
//  CircleButtonAnimation.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 9/03/24.
//

import SwiftUI

struct CircleButtonAnimation: View {

    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(.easeOut(duration: 1.0), value: animate)
            .onAppear {
                animate.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(false))
        .foregroundStyle(.red)
        .frame(width: 100, height: 100)
}

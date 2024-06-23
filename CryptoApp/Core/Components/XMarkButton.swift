//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 27/04/24.
//

import SwiftUI

struct XMarkButton: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemIcon: SystemIcon.xmark)
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}

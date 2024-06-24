//
//  Views.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


extension View {
    @ViewBuilder func hideNavigationBar() -> some View {
        if #available(iOS 16, *) {
            self.toolbar(.hidden)
        }
        self.navigationBarHidden(true)
    }
}

extension Text {
    init(_ localizableKey: LocalizableKeys) {
        self.init(localizableKey.localizedStringKey)
    }
}

extension TextField where Label == Text {
    init(_ localizableKey: LocalizableKeys, text: Binding<String>) {
        self.init(localizableKey.localizedStringKey, text: text)
    }
}

extension Link where Label == Text {
    init(_ localizableKey: LocalizableKeys, destination: URL) {
        self.init(localizableKey.localizedStringKey, destination: destination)
    }
}

extension View {
    func navigationTitle(_ localizableKey: LocalizableKeys) -> some View {
        return self.navigationTitle(localizableKey.localizedStringKey)
    }
}

extension Image {
    init(systemIcon: SystemIcon) {
        self.init(systemName: systemIcon.rawValue)
    }
}

extension Button where Label == Text {
    init(_ localizableKey: LocalizableKeys, role: ButtonRole? = nil, action: @escaping () -> Void) {
        self.init(localizableKey.localizedStringKey, role: role, action: action)
    }
}

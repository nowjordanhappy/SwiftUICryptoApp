//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

@main
 struct CryptoAppApp: App {

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
 

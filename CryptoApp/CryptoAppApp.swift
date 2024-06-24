//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

@main
 struct CryptoAppApp: App {

    @StateObject var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            if showLaunchView {
                LaunchView(showLaunchView: $showLaunchView)
                    .transition(.move(edge: .leading))
            } else {
                ZStack {
                    NavigationView {
                        HomeView()
                            .hideNavigationBar()
                    }
                    .environmentObject(vm)
                }
            }
        }
    }
}
 

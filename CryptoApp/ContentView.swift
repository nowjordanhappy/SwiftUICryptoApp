//
//  ContentView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(wrappedValue: false, AppStorageKeys.hasSeenOnboarding) private var hasSeenOnBoarding: Bool

    @StateObject var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init() {
        hasSeenOnBoarding = false
    }

    var body: some View {

        if showLaunchView {
            LaunchView(showLaunchView: $showLaunchView)
                .transition(.move(edge: .leading))
        } else {
            if hasSeenOnBoarding {
                ZStack {
                    NavigationView {
                        HomeView()
                            .hideNavigationBar()
                    }
                    .navigationViewStyle(.stack)
                    .environmentObject(vm)
                }
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    ContentView()
}

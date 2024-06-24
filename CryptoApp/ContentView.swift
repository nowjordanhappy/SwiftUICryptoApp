//
//  ContentView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    var body: some View {
        if showLaunchView {
            LaunchView(showLaunchView: $showLaunchView)
                .transition(.move(edge: .leading))
        } else {
            ZStack {
                NavigationView {
                    HomeView()
                        .hideNavigationBar()
                }
                .navigationViewStyle(.stack)
                .environmentObject(vm)
            }
        }
    }
}

#Preview {
    ContentView()
}

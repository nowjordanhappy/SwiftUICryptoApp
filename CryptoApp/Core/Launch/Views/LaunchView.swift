//
//  LaunchView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 23/06/24.
//

import SwiftUI

struct LaunchView: View {

    private var loadingMessage: LocalizableKeys = .loadingMessageLaunchScreen
    private let maxLoops: Int = 1
    
    @State private var loadingText: [String]
    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 0.075, on: .main, in: .common)
        .autoconnect()

    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool

    init(showLaunchView: Binding<Bool>) {
        self._showLaunchView = showLaunchView
        loadingText = loadingMessage.getLocalizedString().map { String($0) }
    }

    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()

            Image(.logoTransparent)
                .resizable()
                .frame(width: 100, height: 100)

            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeInOut))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1

                    if loops >= maxLoops {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
        // .environment(\.locale, .init(identifier: "es"))
}

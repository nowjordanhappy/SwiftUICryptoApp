//
//  OnboardingView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 11/07/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage(wrappedValue: false, AppStorageKeys.hasSeenOnboarding) private var hasSeenOnBoarding: Bool

    var body: some View {
        ZStack {
            Color.onboarding.background
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Image(.logo)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)

                Text(.onboardingWelcome)
                    .foregroundStyle(Color.onboarding.secondaryText)
                    .font(.title3.weight(.bold))

                Spacer()

                VStack(spacing: 40) {
                    Text(.onboardingDescription)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundStyle(.black.opacity(0.7))

                    Button(action: {
                        hasSeenOnBoarding = true
                    }, label: {
                        Text(.onboardingStartNow)
                            .bold()
                            .frame(width: 200)
                    })
                    .buttonStyle(
                        GrowingButton(
                            color: Color.onboarding.accent,
                            textColor: Color.white
                        )
                    )
                }

                Spacer()

                Text(.byAuthor)
                    .foregroundStyle(.gray)
                    .font(.callout.weight(.regular))
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingView()
}

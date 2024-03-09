//
//  HomeView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

struct HomeView: View {

    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                homeHeader

                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(icon: showPortfolio ? .plus : .info)
                .animation(.none, value: UUID())
                .background(
                    CircleButtonAnimation(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? .portfolio : .livePrices)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: UUID())
            Spacer()
            CircleButtonView(icon: SystemIcon.chevronRight)
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .hideNavigationBar()
    }
}

#Preview {
    NavigationView {
        HomeView()
            .hideNavigationBar()
            .environment(\.locale, .init(identifier: "es"))
    }
}

//
//  HomeView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 8/03/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = true // animate right
    @State private var showPortfolioView: Bool = false // new sheet

    init() {
        debugPrint("HomeView showPortfolio \(showPortfolio)")
    }

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(viewModel)
                })

            VStack {
                homeHeader

                HomeStatsView(showPortfolio: $showPortfolio)

                SearchBarView(searchText: $viewModel.searchText)
                
                columTitles

                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                        .refreshable {
                            viewModel.reloadData()
                        }
                }

                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .hideNavigationBar()
    }
    .environmentObject(HomeViewModel())
}

#Preview {
    NavigationView {
        HomeView()
            .hideNavigationBar()
            .environment(\.locale, .init(identifier: "es"))
    }
    .environmentObject(HomeViewModel())
}

extension HomeView {

    private var homeHeader: some View {
        HStack {
            CircleButtonView(icon: showPortfolio ? .plus : .info)
                .animation(.none, value: UUID())
                .background(
                    CircleButtonAnimation(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
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
                        print("showPortfolio \(showPortfolio)")
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }

    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }

    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }

    private var columTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text(.coin)
                Image(systemName: SystemIcon.chevronDown.rawValue)
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text(.holdings)
                    Image(systemName: SystemIcon.chevronDown.rawValue)
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text(.price)
                Image(systemName: SystemIcon.chevronDown.rawValue)
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }

            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadData()
                }
            }, label: {
                Image(systemName: SystemIcon.goforward.rawValue)
            })
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

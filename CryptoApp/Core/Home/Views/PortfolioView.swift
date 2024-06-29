//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 27/04/24.
//

import SwiftUI

struct PortfolioView: View {

    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var selectedCoin: CoinModel?
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false

    @Environment(\.dismiss) var dismiss

    init(selectedCoin: Binding<CoinModel?>) {
        _selectedCoin = selectedCoin
    }


    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { scroll in
                    VStack(alignment: .leading, spacing: 0) {
                        SearchBarView(searchText: $viewModel.searchText)

                        coinLogoList

                        if selectedCoin != nil {
                            portfolioInputSection
                        }
                    }
                    .onAppear(perform: {
                        if let coin = selectedCoin {
                            withAnimation(.easeInOut) {
                                updateSelectedCoinQuantity(coin: coin)
                                scroll.scrollTo(coin.id, anchor: .center)
                            }
                        }
                    })
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle(LocalizableKeys.editPortfolio)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButtons
                }
            })
            .onChange(of: viewModel.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
        /*.onAppear(perform: {
         if let coin = selectedCoin {
         updateSelectedCoinQuantity(coin: coin)

         }
         })*/
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(selectedCoin: .constant(nil))
            .environmentObject(dev.homeViewModel)
    }
}

extension PortfolioView {
    private var searchListCoins: [CoinModel] {
        // if there're coins in portfolio and search string is empty, than will be shown allCoins,
        // otherwise will portfolio coins
        viewModel.searchText.isEmpty && !viewModel.portfolioCoins.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins
    }


    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(searchListCoins) { coin in
                    CoinLogoView(coin: coin)
                        .id(coin.id)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                        Color.theme.green : Color.clear, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        )
                }
            }
            .frame(height: 120)
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }

    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin

        updateSelectedCoinQuantity(coin: coin)
    }

    private func updateSelectedCoinQuantity(coin: CoinModel) {
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }), let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount )"
        } else {
            quantityText = ""
        }
    }

    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text(LocalizableKeys.currentPriceOf.getLocalizedString(selectedCoin?.symbol.uppercased() ?? ""))
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
            }
            Divider()
            HStack {
                Text(LocalizableKeys.amountInPortfolio)
                Spacer()
                TextField(LocalizableKeys.quantityPlaceholder, text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text(LocalizableKeys.currentValue)
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
            //Text("selectedCoin?.currentHoldings: \(selectedCoin?.currentHoldings)")
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }

    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemIcon: SystemIcon.checkmark)
                .opacity(showCheckmark ? 1.0 : 0.0)

            Button(action: {
                saveButtonPressed()
            }, label: {
                Text(LocalizableKeys.save)
                    .textCase(.uppercase)
            })
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) && quantityText != "") ? 1.0 : 0.0)
        }
        .font(.headline)
    }

    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }

        // Save to portfolio
        viewModel.updatePortfolio(coin: coin, amount: amount)

        // Show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }

        // hide keyboard
        UIApplication.shared.endEditing()

        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }

    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}

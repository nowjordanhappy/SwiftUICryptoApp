//
//  DetailView.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 9/06/24.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}

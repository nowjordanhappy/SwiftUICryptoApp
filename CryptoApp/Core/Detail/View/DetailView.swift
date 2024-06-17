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
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)

                overviewTitle
                Divider()
                overviewGrid

                aditionalTitle
                Divider()
                addionalGrid
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}

extension DetailView {
    private var overviewTitle: some View {
        Text(.overview)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var aditionalTitle: some View {
        Text(.additionalDetails)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }

    private var addionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
}

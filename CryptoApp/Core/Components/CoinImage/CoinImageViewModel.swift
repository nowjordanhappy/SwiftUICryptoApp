//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 29/03/24.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = true

    private let coin: CoinModel
    private let networkingManager: NetworkingManager
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.networkingManager = NetworkingManager()
        self.dataService = CoinImageService(networkingManager: networkingManager, coin: coin)

        self.addSubscribers()
        self.isLoading = true
    }

    private func addSubscribers() {
        dataService.$image
            .sink { _ in
                self.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}

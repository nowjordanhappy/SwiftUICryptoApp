//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 29/03/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    let networkingManager: NetworkingManager

    @Published var image: UIImage?
    private let coin: CoinModel
    private var imageSubscription: AnyCancellable?

    init(networkingManager: NetworkingManager, coin: CoinModel) {
        self.coin = coin
        self.networkingManager = networkingManager
        getCoinImage()
    }

    private func getCoinImage() {
        debugPrint("getCoinImage")
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = networkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: networkingManager.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedImage in
                debugPrint("getCoinImage returnedImage")
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}

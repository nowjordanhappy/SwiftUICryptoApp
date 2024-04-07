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
    private let fileManager = LocalFileManager.instance
    private var imageSubscription: AnyCancellable?
    private let folderName = "coin_image"
    private let imageName: String

    init(networkingManager: NetworkingManager, coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        self.networkingManager = networkingManager
        self.getCoinImage()
    }

    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        debugPrint("getCoinImage")
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = networkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: networkingManager.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedImage in
                debugPrint("getCoinImage returnedImage")
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}

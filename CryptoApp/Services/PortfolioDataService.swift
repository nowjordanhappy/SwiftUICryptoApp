//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 4/05/24.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"

    @Published var saveEntities: [PortfolioEntity] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error laoding Core Data: \(error)")
            }
            self.getPortfolio()
        }
    }

    // MARK: - PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = saveEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else if amount > 0 {
            add(coin: coin, amount: amount)
        }
    }

    // MARK: - PRIVATE

    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            saveEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetiching Portfolio Entities. \(error)")
        }
    }

    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        appleChanges()
    }

    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        appleChanges()
    }

    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        appleChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }

    private func appleChanges() {
        save()
        getPortfolio()
    }
}

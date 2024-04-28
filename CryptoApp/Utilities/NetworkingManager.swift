//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 17/03/24.
//

import Foundation
import Combine

class NetworkingManager {

    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown erro occured"
            }
        }
    }

    func sendJSONData<T: Encodable>(_ jsonData: T) -> AnyPublisher<Data, Error> {
        do {
            let data = try JSONEncoder().encode(jsonData)
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try self.handleURLResponse(output: $0, url: url)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }

    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func readLocalJSON(nameFile: String) -> AnyPublisher<Data, Error> {
        return Just(nameFile)
            .setFailureType(to: Error.self)
            .flatMap { name -> AnyPublisher<Data, Error> in
                if let pathFile = Bundle.main.path(forResource: name, ofType: "json") { 
                    return Future<Data, Error> { completion in
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: pathFile))
                            completion(.success(data))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkingError.unknown)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

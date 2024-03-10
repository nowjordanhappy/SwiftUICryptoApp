//
//  SparklineIn7DDtoMapper.swift
//  CryptoApp
//
//  Created by Jordan Rojas Alarcon on 10/03/24.
//

import Foundation

struct SparklineDtoMapper {
    func mapToDomainModel(from model: SparklineIn7DDto) -> SparklineIn7D {
        return SparklineIn7D(price: model.price)
    }
}

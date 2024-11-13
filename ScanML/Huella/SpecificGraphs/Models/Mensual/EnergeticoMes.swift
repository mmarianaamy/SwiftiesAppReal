//
//  EnergeticoMes.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 13/11/24.
//

import SwiftUI

struct EnergeticoMes: Identifiable {
    var id: UUID = .init()
    var date: Date
    var emissions: Double
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        dateFormatter.locale = Locale(identifier: "es")
        return dateFormatter.string(from: date).capitalized
    }
}

extension [EnergeticoMes] {
    func findEmissions(_ on: String) -> Double? {
        if let emission = self.first(where: {
            $0.month == on
        }) {
            return emission.emissions
        }
        
        return nil
    }
    
    func index(_ on: String) -> Int {
        if let index = self.firstIndex(where: {
            $0.month == on
        }) {
            return index
        }
        
        return 0
    }
}

var energeticoMes: [EnergeticoMes] = [
    .init(date: .createDate(1, 1, 2024), emissions: .random(in: 6000...45000)),
    .init(date: .createDate(1, 2, 2024), emissions: .random(in: 6000...45000)),
    .init(date: .createDate(1, 3, 2024), emissions: .random(in: 6000...45000)),
    .init(date: .createDate(1, 4, 2024), emissions: .random(in: 6000...45000)),
    .init(date: .createDate(1, 5, 2024), emissions: .random(in: 6000...45000)),
    .init(date: .createDate(1, 6, 2024), emissions: .random(in: 6000...45000))
]


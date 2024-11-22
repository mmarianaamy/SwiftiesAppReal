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




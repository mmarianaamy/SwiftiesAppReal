//
//  CO2Mes.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 13/11/24.
//

import SwiftUI

struct CO2Mes: Identifiable {
    var id: UUID = .init()
    var date: Date
    var emissions: Double
    
    ///Está para mostrar los meses en español
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        dateFormatter.locale = Locale(identifier: "es")
        return dateFormatter.string(from: date).capitalized
    }
}

extension [CO2Mes] {
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

var co2Mes: [CO2Mes] = [
]


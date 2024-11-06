//
//  EmissionData.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import Foundation
import SwiftUI

struct Emissions: Identifiable {
    var id: UUID = .init()
    var type: String
    var emissions: Double
    
}

extension [Emissions] {
    func findDownloads(_ on: String) -> Double? {
        if let emission = self.first(where: {
            $0.type == on
        }) {
            return emission.emissions
        }
        
        return nil
    }
    
    func index(_ on: String) -> Int {
        if let index = self.firstIndex(where: {
            $0.type == on
        }) {
            return index
        }
        
        return 0
    }
}

///test data

var mockupDataTotalEmissions: [Emissions] = [
    .init(type: "Liters", emissions: 5000),
    .init(type: "Electric", emissions: 4500),
    .init(type: "CO2e metric tons", emissions: 2500),
]


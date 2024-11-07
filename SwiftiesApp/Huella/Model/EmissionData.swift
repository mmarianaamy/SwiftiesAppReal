//
//  EmissionData.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI
import Foundation


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
    .init(type: "Energetica", emissions: .random(in: 6000...45000)),
    .init(type: "Carbono", emissions: .random(in: 3500...45000)),
    .init(type: "Hidrica", emissions: .random(in: 12000...45000)),
]


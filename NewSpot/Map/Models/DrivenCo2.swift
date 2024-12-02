//
//  DrivenCo2.swift
//  New Spot
//
//  Created by Jorge Salcedo on 01/12/24.
//

import Foundation

struct DrivenCo2 {
    
    var emissions: Double
    
    mutating func calculateEmissions(distance: Double) {
        let factorUrbano = 1.2
        let factorEmisionesPromedio = 2.31
        let consumoGasolina = 7.0
        
        emissions = (distance / 1000) / 100 * factorUrbano * factorEmisionesPromedio * consumoGasolina
    }
}

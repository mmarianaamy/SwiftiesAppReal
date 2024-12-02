//
//  New_SpotTests_S.swift
//  New SpotTests S
//
//  Created by Jorge Salcedo on 01/12/24.
//

import Testing
@testable import New_Spot

struct New_SpotTests_S {
    
    @Test("Calculate CO2 from driven distance ", arguments: [100])
    func calculateCO2(distance newValue: Double) async throws {
        var co2 = DrivenCo2(emissions: 0)
        co2.calculateEmissions(distance: newValue)
        
        #expect(co2.emissions == 0.019403999999999998)
    }
    
}

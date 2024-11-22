//
//  location.swift
//  New Spot
//
//  Created by Jorge Salcedo on 21/11/24.
//

import Foundation
import MapKit


class LocationResult: ObservableObject{
    @Published var title: String?
    @Published var subtitle: String?
    @Published var eta: Double?
    @Published var distance: Double?
    @Published var steps: [MKRoute.Step]?
    
    
    public func getTile(){
        print("location model title result: \(title ?? "empty")")
    }
}

//
//  location.swift
//  New Spot
//
//  Created by Jorge Salcedo on 21/11/24.
//

import Foundation


class LocationResult: ObservableObject{
    @Published var title: String?
    @Published var subtitle: String?
    @Published var eta: Double?
    @Published var distance: Double?
    
    public func getTile(){
        print("location model title result: \(title ?? "empty")")
    }
}

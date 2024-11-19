//
//  LocationManager.swift
//  New Spot
//
//  Created by Jorge Salcedo on 19/11/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        ///Falta pedir autorizacion AlwaysAndWhenInUse
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation()
        ///Quizas se tenga que seguir actualizando la ubicación del usuario y guardar estos datos en un arreglo
        ///No sé si sea buena idea porque va a gastar muchos recursos
        /// //locationManager.stopUpdatingLocation()
        /// print(locations.first)
    }
}

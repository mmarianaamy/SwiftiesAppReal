//
//  MapView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 16/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        //Map(position: .constant(.region(region)))
        CustomMapViewRepresentable()
    }
    
    private var region: MKCoordinateRegion {
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
}

#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: 25.650102, longitude:  -100.29065))
}

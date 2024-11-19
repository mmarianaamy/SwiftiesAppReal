//
//  CustomMapViewRepresentable.swift
//  New Spot
//
//  Created by Jorge Salcedo on 19/11/24.
//

import Foundation
import SwiftUI
import MapKit

struct CustomMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled=false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocation = locationViewModel.selectedLocation{
            print("Selected location in map view: \(selectedLocation)")
            context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocation)
            
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension CustomMapViewRepresentable{
    class MapCoordinator: NSObject, MKMapViewDelegate{
        let parent: CustomMapViewRepresentable
        init(parent: CustomMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.mapView.setRegion(region, animated: true)
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations) ///Borrar anotaciones previas, para que solo se vea una a la vez
            let annotatioooon = MKPointAnnotation()
            annotatioooon.coordinate = coordinate
            self.parent.mapView.addAnnotation(annotatioooon)
            self.parent.mapView.selectAnnotation(annotatioooon, animated: true) //opcional la neta
            
            ///Actualizar la vista del mapa para que se muestren ambos puntos. El usuario y la anotación.
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
            
            
        }
        
    }
}

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
    @Binding var mapState: MapViewState
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled=false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Map State (debug from MapRepresentable in func updateUI): \(mapState)")
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let selectedLocation = locationViewModel.selectedLocation {
                print("Selected location in map view: \(selectedLocation)")
                
                // Only clear the map and reconfigure if the location is different
                context.coordinator.clearMapView()
                context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocation)
                context.coordinator.configurePolyLine(withDestinationCoordinate: selectedLocation)
            }
            break
        }
    }

    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension CustomMapViewRepresentable{
    class MapCoordinator: NSObject, MKMapViewDelegate{
        let parent: CustomMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        init(parent: CustomMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            // MARK: - Check if user location has moved

            guard let previousLocation = userLocationCoordinate else {
                // If it's the first update, save the user location and return
                self.userLocationCoordinate = userLocation.coordinate
                return
            }

            ///Calcular la distancia entre las ultimas 2 ubicaciones tomadas del usuario para determinar si se actualiza el mapa o no
            let currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let previousLocationInstance = CLLocation(latitude: previousLocation.latitude, longitude: previousLocation.longitude)
            let distance = currentLocation.distance(from: previousLocationInstance)
            if distance >= 60 {
                self.userLocationCoordinate = userLocation.coordinate
                print("distance was more than 300 meters")

                let region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                self.currentRegion = region

                parent.mapView.setRegion(region, animated: true)
            }
        }

        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations) ///Borrar anotaciones previas, para que solo se vea una a la vez
            //clearMapView() ///No sé si esto arregla el problema de tener varias lineas al mismo tiempo. //No, no lo arregla.
            let annotatioooon = MKPointAnnotation()
            annotatioooon.coordinate = coordinate
            self.parent.mapView.addAnnotation(annotatioooon)
            self.parent.mapView.selectAnnotation(annotatioooon, animated: true) //opcional la neta
            
            ///Actualizar la vista del mapa para que se muestren ambos puntos. El usuario y la anotación.
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
            
            
        }
        
        var previousLocation: CLLocationCoordinate2D?
        ///I'm using getDestinationRoute inside of this. The route(s) have not been generated before this
        func configurePolyLine(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            
            // A tolerance value to handle small floating-point precision differences
            let tolerance: Double = 0.000001
            
            // Check if the coordinates are equal within the tolerance
            if let previousLocation = previousLocation,
               abs(previousLocation.latitude - coordinate.latitude) < tolerance,
               abs(previousLocation.longitude - coordinate.longitude) < tolerance {
                return
            }
            
            // Remove old polylines and annotations
            parent.mapView.removeOverlays(parent.mapView.overlays)
            previousLocation = coordinate
            
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                //MARK: Debug-
                print("route description: \(route.description)")
                print("advisory notices: \(route.advisoryNotices)")
                print("distance in meters: \(route.distance)")
                print("expected travel time: \(route.expectedTravelTime)")
                print("steps (huh?) \(route.steps)")
                for (index, step) in route.steps.enumerated() {
                    print("\(index): \(step.instructions)")
                    print("\(index): \(step.distance)")
                    }
                //end debug
                
            }
        }

        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void ){
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destination = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destination)
            let directions = MKDirections(request: request)
            ///This is calling an API. Apple uses it to generate the searchs behind scene
            directions.calculate { response, error in
                if let error = error {
                    print("Failed to get directions with error \(error.localizedDescription)")
                    return
                }
                ///Up to here there are more than one potential routes being returned
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
        
        
        func clearMapViewAndRecenterOnUserLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            ///Go back to user location in map region
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
        func clearMapView(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
        }
        
    }
}

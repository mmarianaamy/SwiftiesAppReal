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
        print("Map State: \(mapState)")
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let selectedLocation = locationViewModel.selectedLocation{
                print("Selected location in map view: \(selectedLocation)")
                context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocation)
                context.coordinator.configurePolyLine(withDestinationCoordinate: selectedLocation)
            }
            break
        
        }
        
        //if mapState == .noInput{
        //    context.coordinator.clearMapViewAndRecenterOnUserLocation()
        //}
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
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
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
        
        ///I'm using getDestinationRoute inside of this. The route(s) have not been generated before this
        func configurePolyLine(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            ///Removes previous polylines. I don't know why the other one is not deleted previously. It should have been deleted, but deleting it here should work
            ///Update: It didn't
            ///Update2: It did
            ////Update3: No it didn't
            ///Final Update: It did
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                //MARK: Debug-
                print("route description: \(route.description)")
                print("advisory notices: \(route.advisoryNotices)")
                print("distance in meters: \(route.distance)")
                print("expected travel time: \(route.expectedTravelTime)")
                print("steps (huh?) \(route.steps)")
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
        
    }
}

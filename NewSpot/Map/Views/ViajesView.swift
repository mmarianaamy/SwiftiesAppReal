//
//  ViajeView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 16/10/24.
//

import SwiftUI
import CoreLocation

struct ViajeView: View {
    //@State private var showLocationSearchView: Bool = false
    @State private var mapState = MapViewState.noInput
    //@State var selection = 0
    
    @State var popup = true
    
    var body: some View {
        
        /*VStack {
         
         MapView(coordinate: CLLocationCoordinate2D(latitude: 25.650102, longitude:  -100.29065))
         .frame(height: 450)
         
         
         Text("Tu viaje de hoy")
         .font(.largeTitle)
         .bold()
         .foregroundStyle(Color.primary)
         Picker("Caminando, Bici, o Carro", selection: $selection) {
         Text("Caminando").tag(0)
         Text("Bici").tag(1)
         Text("Carro").tag(2)
         }
         .pickerStyle(.segmented).padding()
         
         Button {
         
         } label: {
         Text("Listo")
         .padding(.horizontal)
         .padding(.vertical, 8)
         }
         .buttonStyle(.borderedProminent)
         }*/
        ZStack(alignment: .top) {
            CustomMapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea(.container, edges: .top)
            
            if mapState == .noInput{
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            //showLocationSearchView.toggle()
                            mapState = .searchingForLocation
                        }
                    }
            } else if mapState == .searchingForLocation{
                LocationSearchView(mapState: $mapState).onAppear(){
                    popup = true
                }
            } else if mapState == .locationSelected{
                popupView(isPresented: $popup, mapState: $mapState)
                
            }
            
            MapViewActionButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

#Preview {
    @Previewable @StateObject var locationViewModel = LocationSearchViewModel()
    @Previewable @StateObject var locationResult = LocationResult()
    ViajeView()
        .environmentObject(locationViewModel)
        .environmentObject(locationResult)
}

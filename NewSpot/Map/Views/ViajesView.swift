//
//  ViajeView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 16/10/24.
//

import SwiftUI
import CoreLocation

struct ViajeView: View {
    @State private var showLocationSearchView: Bool = false
    //@State var selection = 0
    
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
            CustomMapViewRepresentable()
                .ignoresSafeArea()
            
            if !showLocationSearchView{
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSearchView.toggle()
                        }
                    }
            } else {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
       
        
        
        
    }
}

#Preview {
    ViajeView()
}

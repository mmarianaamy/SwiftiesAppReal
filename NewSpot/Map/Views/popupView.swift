//
//  popupView.swift
//  New Spot
//
//  Created by Jorge Salcedo on 21/11/24.
//

import SwiftUI

struct popupView: View {
    @EnvironmentObject var locationResult: LocationResult
    @Binding var isPresented: Bool
    @State var isShowingRoute = false
    @Binding var mapState: MapViewState
    var body: some View {
        ZStack {
            if isPresented {
                popupContent
                    .transition(.opacity)
                    .zIndex(1)
            }
            if isShowingRoute {
                popupContent2
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
    
    private var popupContent2: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    // Safely accessing the second step if it exists
                    if let secondStep = locationResult.steps?.dropFirst().first {
                        HStack {
                            Text(secondStep.instructions) // Safely unwrap instructions
                                .bold()
                        }
                    } else {
                        HStack {
                            Text("Ruta confirmada")
                                .foregroundStyle(.secondary)
                                .bold()
                        }
                    }
                }
                .foregroundStyle(Color.primary)
                .padding()
                .font(.body)
                .frame(width: UIScreen.main.bounds.width - 96)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 96)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
                .shadow(radius: 15)
        )
    }
    
    private var popupContent: some View {
        VStack {
            Text(locationResult.title ?? "")
                .padding(.top)
                .font(.title3)
                .bold()
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Tiempo estimado:")
                        Spacer()
                        Text("\(Int(ceil((locationResult.eta ?? 0) / 60))) min")
                            .bold()
                    }
                    Divider().background(.primary)
                    
                    HStack {
                        Text("Distancia:")
                        Spacer()
                        Text(
                            locationResult.distance ?? 0 > 1000
                            ? "\(String(format: "%.2f", (locationResult.distance ?? 0) / 1000)) km"
                            : "\(String(format: "%.0f", locationResult.distance ?? 0)) m"
                        )
                        .bold()
                    }
                    Divider()
                        .background(.primary)
                    
                    HStack {
                        Text("Emisiones:")
                        Spacer()
                        Text(String(format: "%.2f", (locationResult.distance ?? 0) / 1000 / 100 * 1.2 * 2.31 * 7) + " kgCO2")
                            .bold()
                        //km / 100 * factor urbano * factor de emisiones promedio * consumo de gasolina de un carro promedio
                    }
                }
                //.padding(.bottom, 4)
                .foregroundStyle(Color.primary)
                .padding()
                
                //.padding(.leading, 20)
                .font(.body)
                .frame(width: UIScreen.main.bounds.width - 96)
                /*.background {
                 RoundedRectangle(cornerRadius: 15)
                 .stroke(Color.gray, lineWidth: 0.5)
                 .fill(Color.white.opacity(1))
                 }*/
            }
            
            HStack (spacing: 0){
                Button {
                    print("ruta confirmada")
                    isPresented.toggle()
                    isShowingRoute.toggle()
                    //MARK: To do ---
                    // hacer que se guarde el valor en la base de datos
                    ///Debug
                    /*for (index, step) in locationResult.steps!.enumerated() {
                     print("popupview -\(index): \(step.instructions)")
                     print("\(index): \(step.distance)")
                     }*/
                } label: {
                    Text("Aceptar")
                        .foregroundStyle(.blue)
                        .bold()
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(.plain)
                
                Divider().frame(width: 1, height: 30)
                    .background(Color.primary)
                
                
                Button {
                    print("ruta cancelada")
                    //MARK: TO DO -
                    //quiero regresar al estado .noInput?(se ve feo)
                    //mapState = .noInput
                    
                    //Task{try? await Task.sleep(nanoseconds: 0_350_000_000)}
                    
                    withAnimation(.spring()){
                        actionForState(mapState)}
                    
                    isPresented.toggle()
                    
                } label: {
                    Text("Cancelar")
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
                .tint(.red)
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 7)
            .padding(.top, -4)
            
        }
        .frame(width: UIScreen.main.bounds.width - 96)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
                .shadow(radius: 15)
        )
    }
    
    func actionForState(_ state: MapViewState){
        switch state {
        case .noInput:
            print("No input")
        case .locationSelected:
            mapState = .noInput
        case .searchingForLocation:
            //print("Searching for location")
            mapState = .noInput
        }
    }
    
}


#Preview {
    @Previewable @StateObject var locationResult = LocationResult()
    Text("hi").foregroundStyle(.clear).onAppear {
        locationResult.distance = 518000
        locationResult.eta = 100
        locationResult.title = "Republiqué Café"
        locationResult.subtitle = "123 Main St, Anytown, USA"
    }
    VStack {
        popupView(isPresented: .constant(true), mapState: .constant(.locationSelected))
            .environmentObject(locationResult)
        Spacer()
    }.background(.ultraThinMaterial)
    
}

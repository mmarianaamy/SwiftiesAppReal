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
    
    var body: some View {
        ZStack {
            if isPresented {
                popupContent
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
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
                        Text(String(format: "%.2f", (locationResult.eta ?? 0)/60) + " min")
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
                        Text("Emisiones estimadas:")
                        Spacer()
                        Text(String(format: "%.2f", (locationResult.distance ?? 0) * 1.2))
                            .bold()
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
                    isPresented.toggle() //MARK: TO DO -
                    // hacer que se guarde el valor en la base de datos
                } label: {
                    Text("Aceptar")
                        .foregroundStyle(.blue)
                        .bold()
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(.plain)
                
                Divider().frame(width: 1, height: 30)
                    
                
                Button {
                    print("ruta cancelada")
                    //MARK: TO DO -
                    //regresar al estado .noInput
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
}


#Preview {
    @Previewable @StateObject var locationResult = LocationResult()
    Text("hi").foregroundStyle(.clear).onAppear {
        locationResult.distance = 100
        locationResult.eta = 100
        locationResult.title = "Republiqué Café"
        locationResult.subtitle = "123 Main St, Anytown, USA"
    }
    VStack {
        popupView(isPresented: .constant(true))
            .environmentObject(locationResult)
        Spacer()
    }.background(.ultraThinMaterial)
}

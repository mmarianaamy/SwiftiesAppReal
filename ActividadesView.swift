//
//  HoyView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 16/10/24.
//

import SwiftUI

struct ActividadesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        VStack {
            Text("Actividades")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.bottom)
            Spacer()
            
            NavigationSplitView {
                ForEach(actividades) { actividad in
                    NavigationLink {
                        if(actividad.name == "Otro"){
                            DetallesActividadView(habitName: "")
                        }else{
                            DetallesActividadView(habitName: actividad.name)
                        }
                    } label: { ActividadView(opcion: actividad.name)
                            .padding(.bottom, 6)
                            .tint(.black)
                        
                    }
                }
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                Text("Listo")
                .padding(.vertical, 8)
                .padding(.horizontal)
                }
                .buttonStyle(.borderedProminent)
            } detail: {
                Text("Elige una actividad")
            }
            
            
            
             
             
        }
    }
}

#Preview {
    ActividadesView()
}

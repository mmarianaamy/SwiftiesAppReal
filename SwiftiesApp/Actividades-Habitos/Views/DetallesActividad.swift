//
//  DetallesActividadView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 17/10/24.
//

import SwiftUI

struct DetallesActividadView: View {
    @State var selectionFrecuency = 0
    @State var selectionTimeUnit = 0
    
    @State var habitName: String
    @State private var description: String = ""
    @State private var time: Double = 10
    
    var body: some View {
        VStack {
            VStack (alignment: .leading){
                Text("Nombre").bold()
                    .padding(.vertical, 7)
                TextField(
                    "Nombre de la actividad",
                    text: $habitName
                )
                .padding(.horizontal)
                .padding(.vertical, 5)
                .foregroundStyle(.black)
                .background(Color.gray.opacity(0.2))
                .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                Text("Descripción").bold()
                    .padding(.vertical, 7)
                TextField(
                    "Opcional",
                    text: $description
                )
                .padding(.horizontal)
                .padding(.vertical, 5)
                .foregroundStyle(.black)
                .background(Color.gray.opacity(0.2))
                .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Text("Duración").bold()
                    .padding(.bottom, -20)
                    .padding(.vertical, 7)
                HStack{
                    TextField("Tiempo", value: $time, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .background(Color.gray.opacity(0.2))
                        .frame(width: 65)
                        .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    Picker("Unidad de tiempo", selection: $selectionTimeUnit) {
                        Text("min").tag(0)
                        Text("hr").tag(1)
                    }
                    .background(Color.gray.opacity(0.2))
                    .frame(width: 70)
                    .containerShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .tint(.black)
                    
                    Text("/")
                    Picker("Frecuencia", selection: $selectionFrecuency) {
                        Text("Dia").tag(0)
                        Text("Semana").tag(1)
                        Text("Mes").tag(1)
                    }
                    .pickerStyle(.segmented).padding()
                }
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                //habits.append(Habit(frecuency: 1, name: "Habit3", date: Date()))
            } label: {
                Text("Listo")
                    .padding(.horizontal)
                    .padding(.vertical, 6)
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
    
}

#Preview {
    DetallesActividadView(habitName: "Bañarme")
}

//
//  DetallesActividadView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 17/10/24.
//

import SwiftUI

struct DetallesHoyView: View {
    @State var selectionFrecuency = 0
    @State var selectionTimeUnit = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var habits: [Habit]
    
    @State var habitName: String = ""
    @State private var description: String = ""
    
    //convertir a double para el futuro sprint
    @State private var time: Int = 10
    
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
                }.padding(.vertical, 7)
                
            }
            .padding(.horizontal)
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
                }.padding(.vertical, 7)
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                if(habitName != ""){
                    //habits.append(Habit(frecuency: time, name: habitName))
                }
                presentationMode.wrappedValue.dismiss()
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
    struct PreviewView : View {
        @State var user : User = User(idusuario: 1, nombre: "Juan", apellido: "Perez", email: "juan.perez@example.com", contraseña: "password123")
        var body : some View {
            DatosView(selection: 1, user: $user)
        }
    }
    
    return PreviewView()
}

//
//  DetallesActividadView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 17/10/24.
//

import SwiftUI
import Supabase

struct DetallesActividadView: View {
    @State var selectionFrecuency = 0
    @State var selectionTimeUnit = 0
    
    @State var habitName: String
    @State private var description: String = ""
    @State private var time: Double = 10
    
    @Environment(\.presentationMode) var presentationMode
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    
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
               /* do{
                    //actividades = try await client.from("habito")
                      //  .select().execute().value
                } catch{
                    print("Not possible")
                }*/
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
    DetallesActividadView(habitName: "Bañarme")
}

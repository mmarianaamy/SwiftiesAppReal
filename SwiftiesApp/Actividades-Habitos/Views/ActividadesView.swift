//
//  HoyView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 16/10/24.
//

import SwiftUI
import Supabase

struct ActividadesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    
    @State var isLoading : Bool = true
    @State var errorMessage : String = ""
    
    @State var actividades : [Actividad] = []
    
    var body: some View {
        
        
        VStack {
            Text("Actividades")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.bottom).task{
                    do{
                        actividades = try await client.from("habito")
                            .select().execute().value
                    } catch{
                        print("Not possible")
                    }
                }
            
            NavigationSplitView {
                ForEach($actividades, id: \.self) { actividad in
                    NavigationLink {
                        if(actividad.nombre.wrappedValue == "Otro"){
                            DetallesActividadView(habitName: "")
                        }else{
                            DetallesActividadView(habitName: actividad.nombre.wrappedValue)
                        }
                    } label: { ActividadView(opcion: actividad.nombre.wrappedValue)
                            .padding(.bottom, 6)
                            .padding(.horizontal, 20)
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

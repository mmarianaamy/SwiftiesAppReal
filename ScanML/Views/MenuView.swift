//
//  MenuView.swift
//  SwiftiesApp
//
//  Created by Alumno on 09/10/24.
//

import SwiftUI
import Intents

struct MenuView: View {
    
    //@Binding var user : User
    //@EnvironmentObject var user: User
    
    var body: some View {
        TabView{
            DatosView().tabItem{
                Label("Datos", systemImage: "chart.bar.fill")
            }.navigationBarTitle("")
                .navigationBarHidden(true)
            HuellasView().tabItem{
                Label("Huellas", systemImage: "chart.pie.fill")
            }.navigationBarTitle("")
                .navigationBarHidden(true)
            ViajeView().tabItem{
                Label("Viajes", systemImage: "car.side")
            }.navigationBarTitle("")
                .navigationBarHidden(true)
            LeaderboardView().tabItem{
                Label("Amigos", systemImage: "person.2")
            }.navigationBarTitle("")
                .navigationBarHidden(true)
            SettingsView()
                .environmentObject(User())
                .tabItem{
                    Label("Configuración", systemImage: "gear")
                }.navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

#Preview {

    @Previewable @StateObject var user = User() // Create an instance of User
    MenuView()
        .environmentObject(user)

}

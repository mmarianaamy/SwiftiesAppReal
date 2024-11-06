//
//  MenuView.swift
//  SwiftiesApp
//
//  Created by Alumno on 09/10/24.
//

import SwiftUI
import Intents

struct MenuView: View {
    
    @Binding var user : User
    
    var body: some View {
        TabView{
            DatosView(user: $user).tabItem{
                Label("Datos", systemImage: "chart.bar.fill")
            }
            HuellasView(user: $user).tabItem{
                Label("Huellas", systemImage: "chart.pie.fill")
            }
            ViajeView().tabItem{
                Label("Viajes", systemImage: "car.side")
            }
            LeaderboardView().tabItem{
                Label("Amigos", systemImage: "person.2")
            }
            ProfileView().tabItem{
                Label("Perfil", systemImage: "person.circle.fill")
            }
        }
    }
}

#Preview {
    struct PreviewView : View {
        @State var user : User = User(idusuario: 1, nombre: "Juan", apellido: "Perez", email: "juan.perez@example.com", contraseña: "password123")
        var body : some View {
            MenuView(user: $user)
        }
    }
    
    return PreviewView()
}
